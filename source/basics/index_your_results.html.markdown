---
title: Index your results
---
## Index your results

Zillabyte provides a way to easily do exhaustive search on the web. Meaning, you can return the entire set matching your flow. However, many of your flows will return millions of results. This may not be useful.  Instead, you can index or order your results, based on your own criteria. 

```ruby
  # Set a score variable to rank your results 
  # based on your own criteria. Here we are saying
  # if the HTML includes YOUR_QUERY1, weight it .7
  # whereas if the HTML includes YOUR_QUERY2, weight
  # it .3. If the HTML includes both terms, give it a 
  # score of 1. 

  score = 0
  if html.include?(YOUR_QUERY1)
    score += .7
  end
  if html.include?(YOUR_QUERY2)
    score += .3
  end

  controller.emit(DATASET_NAME, "URL" => url, "score" => score)
```

For example, using the Domains dataset, create a hello_world index, based on whether certain sites have hello or world or both.

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.name "hello_world_index"
  fn.matches [["domains", ["url", "html"]]] 
  # Create a new dataset with two columns, URL and score. 
  fn.emits [["hello_world_index", ["url", "score"]]] 
  
  fn.execute do |tuple, collector| 
  
  url = tuple['url']
  html = tuple['html'] 
  
  
  # Each site starts with a score of 0. 
  # If hello is found, give it a weight of .7.
  # If world is found, give it a weight of .3.
  # If both are found, give it a weight of 1.
  score = 0
  
  if html.include?('hello')
    score += .7
  end 
  if html.include?('world')
    score += .3
  end 
  
  # Write the url and the score to the hello_world_index dataset.
  controller.emit("hello_world_index", "URL" => url, "score" => score)
  
end 
```

Try the above out by copying it to a Zillabyte directory!




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
