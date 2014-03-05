# How To: Determine Market Coverage of Your App

Zillabyte makes it easy to aggregate small details across the entire web. Market Coverage is an application that determines whether or not your widget is being used on a webpage. This HowTo shows you how to write a simple script that runs on millions of pages to determine if a website is using one of your products, libraries, or connects to your API.

### Use case
Let's say you are a developer working at Tint, a social media feeds display company. Someone from your business development team is trying to determine all the websites that use your software package.

https://d36hc0p18k1aoc.cloudfront.net/pages/a5b5e4.js

and

https://d36hc0p18k1aoc.cloudfront.net/public/js/modules/tintembed.js

indicate that a website is using Tint.

Neither the sales & marketing team nor the business development team is capable of completing this task for the dozens of web domains that employ these analytics products. A simple web scraper could help you figure this out, but you've built a scraper dozens of times before! Spinning up servers, starting your scraper on server machines will take a lot of time and could cost you more than you expect. Then you remember:

## Zillabyte is the web's final scraper.

```ruby
require 'zillabyte'
require 'net/http'
require 'uri'

Zillabyte.simple_function do |fn|
  
  # This directive instructs zillabyte to give your function every 
  # web page in our known universe.  Your function will have access
  # to two fields: URL and HTML
  fn.matches "select * from url"
  fn.name "tint_web_coverage"

  # This directive tells Zillabyte what kind of data your function
  # produces.  In this case, we're saying we will emit a tuple that 
  # is two-columns wide and contains the field 'uses_tint' and 'url'
  fn.emits   [["uses_tint", [{"uses_tint"=> :string}, {"url"=>:string}]]]

  
  # This is the heart of your algorithm.  It's processed on every
  # web page.  This algorithm is run in parallel on possibly hundreds
  # of machines.
  fn.execute do |controller, tuple|
  	url = tuple['URL']
  	begin
  		html = Net::HTTP.get(URI.parse("http://" + url))
      if html.include?('https://d36hc0p18k1aoc.cloudfront.net/pages/a5b5e4.js')
      	controller.emit :uses_tint => "a5b5e4_js", :url => url
      end
      if html.include?('https://d36hc0p18k1aoc.cloudfront.net/public/js/modules/tintembed.js')
      	controller.emit :uses_tint => "tint_embed_js", :url => url
      end
    rescue Exception => e
    	puts "Exception " + e + " caught, oh noes"
    end
  end
end
```

Submiting this code to Zillabyte is easy. Once you've written the above code, save & exit your file. Switch back to the terminal & in the terminal, run:

```ruby
zillabyte push
```

This will upload your code to Zillabyte's infrastructure using your credentials.

### That's it. You're Done. Zillabyte will do the rest of the work from here.

Once you've submitted the above script. Zillabyte will run your code on every webpage in Zillabyte's web corpus (> 15 million urls!). Can your business development team pull this off?

## DID WE MENTION THAT WAS FREE?