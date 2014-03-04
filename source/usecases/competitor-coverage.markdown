# How To: Monitor Your Competitor(s)'s App


### Competitive Intelligence

Zillabyte makes it a lot easier to aggregate small details across the entire web. Competitve intelligence is an application that determines whether or not a competitor's widget is being used on any domain. This HowTo shows you how to write a simple script that runs on millions of pages to determine if a website is using one of your competitor's products.

###	Use Case

Let's say you are an employee at working at Mixpanel, an analytics software company.  

Someone from your business development team is trying to determine all the websites that use KISSmetrics, Google Analytics, Hubspot, or Omniture.

Neither the sales & marketing team nor the business development team is capable of completing this task for the millions of web domains that employ these analytics products. A simple scraper could help you figure this out. You know you need a web scraper to complete this task. Then you remember: 

## Zillabyte is the web's final scraper.

### Implementation

```ruby
require 'zillabyte'
require 'net/http'
require 'uri'

Zillabyte.simple_function do |fn|
  
  # This directive instructs zillabyte to give your function every 
  # web page in our known universe.  Your function will have access
  # to two fields: URL and HTML
  fn.matches "select * from url"
  fn.name "mixpanel_intelligence"

  # This directive tells Zillabyte what kind of data your function
  # produces.  In this case, we're saying we will emit a tuple that 
  # is two-columns wide and contains the field 'competitor' and 'url'
  fn.emits   [["competitors", [{"competitor"=> :string}, {"url"=>:string}]]]

  
  # This is the heart of your algorithm.  It's processed on every
  # web page.  This algorithm is run in parallel on possibly hundreds
  # of machines.
  fn.execute do |controller, tuple|
  	url = tuple['URL']
  	begin
  		html = Net::HTTP.get(URI.parse("http://" + url))
      if html.include?('http://kissmetrics.com')
      	controller.emit :competitor => "KISSmetrics", :url => url
      end
      if html.include?('http://google.com/analytics')
      	controller.emit :competitor => "google_analytics", :url => url
      end
      if html.include?('http://hubspot.com')
      	controller.emit :competitor => "hubspot", :url => url
      end
      if html.include?('http://adobe.com/solutions/digital-marketing.html')
      	controller.emit :competitor => "omniture", :url => url
      end
    rescue Exception => e
    	puts "Exception " + e + " caught, oh noes"
    end
  end
end
```

Submiting this code to Zillabyte is easy. Once you've written the above code, save your work, & exit the file. Switch back to the terminal & in the terminal, run:

```ruby
zillabyte push
```

This will upload your code to Zillabyte's infrastructure using your credentials. 

### Under the Hood

Once you've submitted the above script. Zillabyte will run your code on every webpage in Zillabyte's web corpus (> 15 million urls!). Can your business development team pull this off?

### That's it. You're Done. Zillabyte will do the rest of the work.