# How To: Find Corn Hybrid Listings

Zillabyte makes it easy to aggregate small details across the entire web. Sometimes our users really want to categorize hundreds of webpages based on their key words. 

### Use case
Let's say you are a developer working at for a agricultural company and you need to put webpages into 3 categories. Sites that mention 'AgriGold', 'Mycogen', & 'Syngenta' need to be put into 3 columns in an Excel spreadsheet.


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
  fn.name "corn_hybrid"

  # This directive tells Zillabyte what kind of data your function
  # produces.  In this case, we're saying we will emit a tuple that 
  # is two-columns wide and contains the field 'uses_tint' and 'url'
  fn.emits   [["corn_hybrid", [{"corn_hybrid"=> :string}, {"url"=>:string}]]]

  
  # This is the heart of your algorithm.  It's processed on every
  # web page.  This algorithm is run in parallel on possibly hundreds
  # of machines.
  fn.execute do |controller, tuple|
    url = tuple['URL']
    begin
      html = Net::HTTP.get(URI.parse("http://" + url))
      if html.include?('corn')
        if html.include?('agrigold')
          controller.emit :uses_agrigold => "agrigold", :url => url
        end
        if html.include?('myogen')
          controller.emit :uses_syngenta => "myogen", :url => url
        end
        if html.include?('syngenta')
          controller.emit :uses_syngenta => "syngenta", :url => url
        end
        
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
