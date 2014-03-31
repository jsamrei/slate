# Creating a Commerce Index

Zillabyte makes it aggregate data from the entire web and create an index based on your criteria. 

A Zillabyte customer came to us wanting to rank the web according to the use of commerce technologies. Using Zillabyte, she was able to write a bit of code and get her answer. Here's how you can do it as well. 


### The Code
```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn|
  
  # Every Zillabyte flow needs a name
  fn.name "commerce_index"

  # Your function will have access
  # to two fields as input data: URL and HTML
  fn.matches "select * from web_pages"
  
  # Emit a tuple that is two-columns wide and contains 
  # the attributes 'URL' and 'score', in the relation
  # named "commerce_index".
  fn.emits   [
    ["commerce_index", [{"URL"=>:string}, {"score"=> :float}]]
  ]

  # This is the heart of your algorithm.  It's processed on every
  # web page.  This algorithm is run in parallel on possibly hundreds
  # of machines. 
  fn.execute do |controller, tuple|
    
    # Get the fields from your input data.
    url = tuple['url']
    html = tuple['html']
    
    # You care about three commerce technologies: Bluekai,
    # Gigya, and Scorecard Research.  However, you believe Bluekai
    # should count for more in your index.
    score = 0
    if html.include?('bluekai.com')
      score += 0.7
    end
    if html.include?('cdn.gigya.com/js/gigyaGAIntegration.js')
      score += 0.2
    end
    if html.include?('b.scorecardresearch.com/beacon.js')
      score += 0.1
    end
    
    controller.emit("commerce_index", "URL" => url, "score" => score)
  end

end
```

### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!


