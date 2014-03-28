---
title: HTML Search
---
## Search within a field

Use Zillabyte to search through a field easily. 

```ruby
  # This 3-line block allows you to filter YOUR_DATA_STREAM
  # for COLUMN_1 that has YOUR_QUERY, and creates
  # a new dataset named DATASET_NAME.
  
  if YOUR_DATA_STREAM.include?(YOUR_QUERY)
    controller.emit(DATASET_NAME, COLUMN_1 => VALUE)
  end
```

For example, using the Domains dataset, search through HTML.

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.name "hello_world"
  fn.matches [["domains", ["url", "html"]]] 
  fn.emits [["hello_world", ["url"]]] 
  
  fn.execute do |tuple, collector| 
    
  url = tuple['url']
  html = tuple['html'] 
  
  # This 3-line block allows you to filter the web 
  # for the set of URLs that have HTML which include 
  # the string "hello world", and create a new dataset
  # named "hello_world".
  if html.include?('hello world')
    controller.emit("hello_world", "URL" => url)
  end 

end 
```

Try the above out by copying it to a Zillabyte directory!




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
