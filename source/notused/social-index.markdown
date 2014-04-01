# How To: Determine Growth of Social Media Technologies

Zillabyte makes it easy to aggregate small details across the entire web. 

### Use case
Let's say you are a developer working at a social media feeds display company. Someone from your business development team is trying to determine all the websites that are socially active, since these would be good targets.

Neither the sales & marketing team nor the business development team is capable of completing this task for the dozens of web domains that employ these analytics products. A simple web scraper could help you figure this out, but you've built a scraper dozens of times before! Spinning up servers, starting your scraper on server machines will take a lot of time and could cost you more than you expect. Then you remember:

## Zillabyte is the web's final scraper.

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn|
  
  fn.name "social_score"
  # This directive instructs zillabyte to give your function every 
  # web page in our known universe.  Your function will have access
  # to two fields: URL and HTML
  fn.matches "select * from web_pages"
  
  # This directive tells Zillabyte what kind of data your function
  # produces.  In this case, we're saying we will emit a tuple that 
  # is one-column wide and contains the field 'URL'
  fn.emits   [["social_index", [{"URL"=>:string}, {"score"=> :float}]]]

  
  # This is the heart of your algorithm.  It's processed on every
  # web page.  This algorithm is run in parallel on possibly hundreds
  # of machines. 
  fn.execute do |controller, tuple|
    
    # get the fields
    url = tuple['url']
    html = tuple['html']
    
    # For the purpose of this test, to show results from the test set,
    # we'll loosen the search to include either hello or world
    # instead of
    # if html.include?('hello world')
    score = 0
    if html.include?('twitter.com')
      score += 1
    end
    if html.include?('facebook.com')
      score += 1
    end
    if html.include?('pinterest.com')
      score += 1
    end
    
    controller.emit("social_index", "URL" => url, "score" => score)
  end

end
  
  

```

Submiting this code to Zillabyte is easy. Once you've written the above code, save & exit your file. Switch back to the terminal & in the terminal, run:

```ruby
zillabyte push
```

This will upload your code to Zillabyte's infrastructure using your credentials.

### That's it. You're Done. Zillabyte will do the rest of the work from here.

Once you've submitted the above script. Zillabyte will run your code on every webpage in Zillabyte's web corpus (> 200 million urls!). Can your business development team pull this off?

