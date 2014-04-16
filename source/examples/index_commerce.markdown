# Creating a Commerce Index

Zillabyte makes it aggregate data from the entire web and create an index based on your criteria. 

A Zillabyte customer came to us wanting to rank the web according to the use of commerce technologies. Using Zillabyte, she was able to write a bit of code and get her answer. Here's how you can do it as well. 


### The Code
```ruby
require 'zillabyte'

app = Zillabyte.new "commerce_index_"

input = app.source "select url,html from web_pages"
  
stream = input.each do |tuple| 
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
  
  emit {:url => tuple['url'], :score => score}

stream.sink do 
  name "commerce_index"
  column "url", :string
  column "score", :float
end
```

### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!


