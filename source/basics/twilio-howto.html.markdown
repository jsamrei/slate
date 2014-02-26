= HOWTO: Build a Twilio Flow

## Preliminary research

For any flow, there is work to be done before you ever touch a programming language, and the Twilio usecase was no exception.

### 1. Identify the problem.

The first step to building any flow is to identify exactly what the flow is intended to accomplish. In an ideal situation, Twilio is interested in mobile apps, delivered every week, that:

* Employ two-factor authentication (via SMS).
* Have 500,000 or more downloads per month.
* Are rising in the rankings (new leads).

### 2. Tie things back to the real world.

Once the problem has been identified, it is time to start talking about how to actually build the flow.  For starters, we needed to determine what information was actually available, and ran into some challenges:

* Without asking, there is no consistent way of determinig whether an application uses two-factor authentication.
* Mobile application download numbers are not made public by Apple.
* Rankings for Apple feeds only go down to 300.

### 3. Identify solutions.

While the above obstacles look formidable, there are reasons not to be discouraged.

* We asked Twilio for some of the companies they were interested in and found that nearly all of them were in the top twenty downloads on the iTunes Store.
* We found a paper that correlated number of reviews with number of downloads, for free and paid apps.
* We determined that apps using SMS functionality were likely to have "SMS" in their EULAs, which are linked for each application entry on the iTunes Store website.
* Apple offers RSS feeds with different ranking lists for each genre, country, and a number of other factors, significantly increasing coverage.

## Architect the flow.

Now that potential solutions have been identified, it is time to start actually building the flow.

### 1. Run through the data acquisition process manually.

To make sure that a process is viable, it's important to run through a constrained subset of it completely manually.  If it's not at least in principle doable by a human (albeit one with unlimited patience and speed) then it's going to be difficult to figure out how a computer can do it.

In this case, I was able to visit the iTunes "RSS feed homepage," select a feed I was interested in, and click on a link from that feed to bring me to the application's page in the iTunes Store, determine its star ratings, and read its EULA.  I noticed that the EULA link opened up the iTunes application, not a normal browser.  Using an application called Wireshark I was able to figure out what user agent string the iTunes Store application was sending in order to receive content from the Apple Store.

### 2. Map out the flow.

Now that you've run through the basic process, it's time to make it official.  On a piece of paper, in your favorite text editor, or in your head, map out exactly how the flow will work.  What web resources does it need to hit?  Does it need any initial data seeded from a database?  Will it create multiple relations, or just one?  How will you tie things back together to create the deliverable?

In this case, I needed to hit the iTunes Store RSS feeds, and parse the resulting product pages and EULAs.  The primary sources were going to be statics RSS feed URLS whose structure would not change significantly, and for the most part the resulting data could fit into two relations: a relation between application IDs, the feed for which they were queried, their ranking in that feed, and the date the rankings were queried, a relations between application IDs, the number of reviews they had when queried and whether their EULA had "SMS" in it, and the date on which they were queried.

The reason that there are two relations here is because a single application queried on the same date would necessarily have the same number of reviews (and the same EULA), no matter what its ranking was on that date for a particular feed.  Only repeating each unique fact once helps us be good net citiens and speeds up the flow (by not crawling the same page over and over), and prevents us from accidentally generating invalid data that we have to clean up later.

Finally, I needed to combine the data from the two relations into a deliverable.  This would require taking a snapshot from two runs of the preceding flows one week apart, finding differences in the rankings and ratings, and creating a summary table to be emailed to Twilio.  This was an ideal usecase for a Zillabyte feature called "cycles," which allow one to map entries in a relation from a particular date to an incrementing number representing how many times the flow has been run.  Comparing entries from the previous cycle to that of the just-completed cycle would produce a picture of the changes (in review count and ranking particularly) in which Twilio was interested.

### 3. Choose your source language.

One of the features Zillabyte provides is the ability to choose from between three different programming languages: Ruby, Python, and JavaScript.  Zillabyte allows these languages to be used with libraries from the language's native package management system.  Choice of language may be based on familiarity with the language, available libraries that deal with the problem, and the nature of the content (for example, a flow that requires extensive manipulation of DOM structure might be best suited to node.js, while Python's rich data analytics support with libraries like numpy might make it a better choice for flows requiring detailed statistical modeling).  In this case, I used Ruby, in part because its standard libraries include an RSS parser.

## Into the weeds.

Now that the high level structure of the flow has been determined, it is time to get down to the dirty business of actually programmatically extracting information from the web.  This may be where repeated functionality (which can be modularized) may become apparent.

In this case, there were four distinct phases of this:

### 1. Generating and filtering interesting feeds, and streaming them out for processing.

It became quickly apparent that between the number of different countries, flow types, and media types that iTunes offered, and the fact that many were tied to impenetrable IDs that looked likely to change, it would be best to automatically generate the feeds in the same manner that iTunes itself did.  To that end, I read through the source code for the site and was able to determine the source locations for media types and IDs, countries and IDs, and the way that the links were constructed.  I then replicated this process in Ruby, using ERB templates and creating a structure for each distinct type that Apple had encoded in JSON.  I then wrote a spout that processed these feeds and selected them for interesting characteristics (US applications, only feeds with "app" in their description, and "all genres" since Twilio is not only targeting apps in a particular genre).

### 2. Visting each RSS feed to determine applications of potential interest, and sinking this ranking information to a persistent relation.

This was the easiest part of the process--Ruby has a RSS feed library that allows parsing an extraction of RSS feed items with minimal fuss.  Within an "each", I opened the feed, ran it through the RSS parser, then extracted each application's ID (with a regular expression) and ranking (based on index in the feed) as well as the feed query parameters.  Using a "sink" I then dumped this information to an "itunes_store_rank" relation in the database for later processing.

### 3. Visiting each application's iTunes store page to extract interesting information about the application, and sinking this application information to a persistent relation.

If you have an application's ID, visiting that application in the iTunes store is relatively easy (provided you have the user agent string, as we did thanks to our work during the research phase).  To make sure that we do not visit the same applications multiple times in the store, we aggregate the relevant application IDs from step 2 using a "unique" filter.  Using an "each', we then parse the structure of the web page using the gem Nokogiri, an efficient parser frequently used for DOM manipulation in Ruby, as a dependency in our Gemfile, and extracted the "all time" rankings for the application.  We also extracted the EULA link, and performed a simple text search (using a regular expression) for the term "SMS", which we included as a boolean.  Finally, we use a "sink" to dump this information to the database in the "app_info" relation.

### 4. Tying it all together (comparing it to information from the previous week), by extracting the same information from the last cycle's relation, then email the results to Twilio as a CSV.

This is where cycles come in.  After a batch is done emitting, it uses our Zillabyte "Claws" SQL functionality to extract the results of the previous cycle for applications of interest: top twenty-ranked applications in the new cycle, applications with "RSS" in their EULAs in the new cycle, and applications with a difference between their current cycle and previous cycle review counts that is within the margin of error for an application on pace to exceed 500,000 downloads per month.  It then groups these applications by ID and sends the relevant information (what the app is, and why it is used) to Twilio using the Ruby "mail" gem, which was included as a dependency in our Gemfile.

## Testing, robustness and efficiency.

Now that the flow has been created, it is time to test it for errors and make sure that all expected error cases are handled properly and that edge cases do not cause catastrophic results or invalid data to become part of our dataset.  Because Zillabyte flows are expected to run autonomously and sometimes continuously while extracting information from a variable source (like any on the web), it is important that they be able to recover from a wide variety of problems and run reasonably efficiently.

For example, the first few times I ran the application, I was surprised to find that some fields I had expected to always be present were in fact not present in some situations.  Rather than crash in this rare but possible situation, I opted to catch the error and report a problem to the error logs.

Another thing I did during this phase was clean up parts of the test so that the minimum amount of information was emitted between flow nodes.  At large scales, serialization and deserialization of data can take a significant amount of time, so making sure that (for example) only the URL of a RSS feed was emitted from the spout, rather than the entire contents of the feed, turned out to be an important optimization.  I was able to determine most of this with our zillabyte flows:test CLI command.

One last thing I did was take most of the iTunes functionality and put it into a reusable library.  This way, if I needed to write more flows that relied upon information from the iTunes store, I would be able to simply plug in my already-written code.  This kind of composability is crucial for decreasing iteration time for new flows.

## Ready to push.

With the above accomplished, it's time to push to zillabyte (using zillabyte flows:push).  With any luck, the flow will work, and you'll be receiving useful information before you know it.  I hope this howto provides value to others who want to build flows on top of Zillabyte, both in terms of specific application details and the general thought process behind building an autonomous data extraction system on top of the web.