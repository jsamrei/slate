# How To: Calculate the popularity of a given domain. 

You've probably heard of Page Rank, the algorithm that made Google what it is today.  The basic idea behind Page Rank is straightforward: analyze all the inbound links for a given page then use it to calculate the relevance of that page. 

Let's take that same concept, but apply it to domains.  That is, we wish to determine how popular a given domain is.  We should expect "google.com" and "facebook.com" to rank near the top, and "my_corner_bakery.com" to rank near the bottom. 

Our goal in this exercise is to count the number of domains that point to other domains.  For example, if "http://foo.com/" points to "http://bar.com", then we should give "bar.com" a score of 1.  Likewise, if "http://foo.com/page_1" and "http://bar.com/page_2" point to "baz.com", then we should give "baz.com" a score of 2. 

## Analyzing the Web with Zillabyte

Zillabyte makes this task a breeze.  Zillabyte handles crawling the web and running your algorithm; all you need to do is craft your algorithm in a way that Zillabyte can understand.  This is known as the [Pipe Programming Paradigm](), and it is what allows Zillabyte parallelize your code and process billions of records in short order. 

Let's look at the complete code ([Github Link](https://github.com/zillabyte/examples/tree/master/domain_rank)):

### The Code

```ruby
require 'zillabyte'
require 'nokogiri'


# Create our 'flow', the DSL to help us orchestrate our app
flow = Zillabyte.new()


# A 'spout' is the beginning of a flow.  All data originates from the spout.
# Below, we will simply find which extrenal domains a given page may link to. 
stream = flow.spout do |h|

  h.matches "select * from web_pages"  # Let's consume the whole web. 
  h.emits [:source_domain, :target_domain]  # The data this spout emits.
  
  
  # This is called on every web page
  h.execute do |tuple, controller|
    
    base_url = tuple['url']
    html = tuple['html']
    doc = Nokogiri::HTML(html)
    
    doc.css('a').each do |link| 
      
      # What domain does this item link to? 
      target_uri = URI.join( base_url, link['href'])
      target_domain = target_uri.host.downcase
      
      # Emit this back to the flow.  This is important because it will allow
      # Zillabyte to parallelize the operation
      controller.emit :source_domain => source_domain, :target_domain => target_domain
      
    end
    
  end
end


# de-duplicate the stream.  i.e. throw out all tuples that have matching
# [source_domain, target_domain] pairs
stream.unique()


# Count the number of unique 'target_domain's.  By default, this will create a
# new field called 'count' and throw away all 'source_domain' values
stream.count :target_domain


# Final step, we need to sink the data into Zillabyte.  Sunk data is persistent
# and can be downloaded later. 
web_stream.sink do |h|
  h.name "domain_rank"
  h.column "domain", :string
  h.column "score", :integer
end

```


## What's Going On? 

The above code conforms to the [pipe programming paradigm](). This allows Zillabyte to parallelize the algorithm so we can get results in seconds, not days.  

The above code is broken into four parts: (a) a spout, (b) a uniquer, (c) a counter, and finally (d) a sink.  Let's look at each on in detail. 

### The Spout

All data in a flow must originate from a "spout".  In this particular case, we need to tell Zillabyte what kind of data to source from.  

#### Matches and Emitting Data

A spout consumes data from Zillabyte, processes it, and then passes new data to the rest of the flow.  Observe the following lines: 

```ruby
h.matches "select * from web_pages"  
h.emits [:source_domain, :target_domain]  
```

The first line instructs Zillabyte to feed your spout all of the records in the `web_pages` corpus.  The `web_pages` corpus is a pre-crawled copy of the web and contains two main fields: `url` and `html`.  This is familiar SQL syntax, and later we'll examine how we can use this to pre-process our flow and expedite processing time.

The second line tells the system what kind of data this spout will emit. The fields you define here must match the `emit` functions below. 

#### The Heart of the Spout 

The final component to the spout is the `execute` section.  This is the block of code that actually runs on every web page. 

```ruby
h.execute do |tuple, controller|
  
  base_url = tuple['url']
  html = tuple['html']
  doc = Nokogiri::HTML(html)
  
  doc.css('a').each do |link| 
    
    # What domain does this item link to? 
    target_uri = URI.join( base_url, link['href'])
    target_domain = target_uri.host.downcase
    
    # Emit this back to the flow.  This is important because it will allow
    # Zillabyte to parallelize the operation
    controller.emit :source_domain => source_domain, :target_domain => target_domain
    
  end
  
end
```

The above code does the following: (a) extract the links from a web page, then (b) extract the domain of that link, then (c) emit the domain back to the stream.  Zillabyte allows you to reuse 3rd party libraries.  In this case, we're using [Nokogiri](http://nokogiri.org/) to handle our HTML parsing. 

### The Uniquer

As data emits from the spout, we want to make sure we avoid duplication.  That is, we want to make sure a target domain only gets one point for every source domain.  Because the spout can be parallelized, it makes sense to handle this logic after the spout.  The following line should do the trick:

```
stream.unique()
```


#### The Counter

Now we are going to instruct the flow to start counting.  At this point in the flow, the stream contains two fields: `[source_domain, target_domain]`.  We want to group all the `target_domains` and count the size of it. 

```
stream.count :target_domain
```

The above will group by the field `target_domain` and add a new field called `count`.  The resulting stream will contain two fields: `[target_domain, count]`


#### The Sink

All flows must come to an end.  A sink allows our new data to return to persistent storage inside Zillabyte.  This data can be downloaded later via the Zillabyte CLI.  

```ruby
web_stream.sink do |h|
  h.name "domain_rank"
  h.column "domain", :string
  h.column "score", :integer
end
```

When we sink data, we need to give Zillabyte some meta information about the data being sunk.  In the above, the sink creates a new relation called "domain\_rank".  This relation contains two columns, "domain" and "score".  Order is important here, the first field corresponds to the first field in our stream, "target\_domain", and the second column corresponds to "count". 


## Conclusion & Next Steps 

The above example shows how quickly you can analyze large chunks of the world's information.  In less than 50 lines of code, we were able to understand the popularity distribution of domains across the internet.  

To see the output & practical implications of this analysis, please check out the corresponding blog post: [The Long Tail of the Web]()
