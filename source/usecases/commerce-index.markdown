# How To: Determine Growth of Commercial Technologies

Zillabyte makes it easy to aggregate small details across the entire web. 

### Use case
Let's say you are a developer working at a web analytics startup. Suppose someone from your business development team is trying to determine all the websites that are using trackers & analytics tools. This will help your team determine the extent a particular web page is tracking it's users. This will tell you a lot about a web pages's management team.

## Zillabyte makes web metrics easy.

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn|
  
  fn.name "commerce_index"
  # This directive instructs zillabyte to give your function every 
  # web page in our known universe.  Your function will have access
  # to two fields: URL and HTML
  fn.matches "select * from web_pages"
  
  # This directive tells Zillabyte what kind of data your function
  # produces.  In this case, we're saying we will emit a tuple that 
  # is one-column wide and contains the field 'URL'
  fn.emits   [["commerce_index", [{"URL"=>:string}, {"score"=> :float}]]]

  
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
    if html.include?('bluekai.com')
      score += 0.3
    end
    if html.include?('cdn.gigya.com/js/gigyaGAIntegration.js')
      score += 0.4
    end
    if html.include?('b.scorecardresearch.com/beacon.js')
      score += 0.3
    end
    
    controller.emit("commerce_index", "URL" => url, "score" => score)
  end

end
  
  

```

Submiting this code to Zillabyte is easy. Once you've written the above code, save & exit your file. Switch back to the terminal & in the terminal, run:

```ruby
zillabyte push
```

This will upload your code to Zillabyte's infrastructure using your credentials.

### You just scored webpages based on how aggressively they are tracking their users.


