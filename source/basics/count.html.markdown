---
title: Count 
---
## Count

Sometimes it's not enough to do a binary search, such as "does this page's HTML include "hello"?"  Sometimes you want to count how many times something is on a page.  Zillabyte makes it easy. 

```ruby
  # Set a count variable. And use the groupby 
  # method to count within the page how
  # many times YOUR_QUERY is in the html.
  count = 0
  if html.groupby?(YOUR_QUERY)
    count += 1
  end

  controller.emit(DATASET_NAME, "URL" => url, "count" => count)
```

For example:

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.name "hello_world_index"
  fn.matches [["domains", ["url", "html"]]] 
  fn.emits [["hello_world_index", ["url", "count"]]] 
  
  fn.execute do |tuple, collector| 
  
  url = tuple['url']
  html = tuple['html'] 
  
  count = 0
  if html.groupby?(YOUR_QUERY1)
    count += 1
  end
  
  # Write the url and the count to the hello_world_count dataset.
  controller.emit("hello_world_count", "URL" => url, "count" => count)
  
end 
```

Try the above out by copying it to a Zillabyte directory!

In the coming months, increasingly complex aggregate statistics will be possible, such as counting the instances a term shows up within an entire domain. 


[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
