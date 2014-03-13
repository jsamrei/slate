---
title: Join disparate data sources
---
## Join disparate data sources

Sometimes you need to combine data sources.  In database terminology, this is done through a "join." Zillabyte makes it easy for you to join different data sources.  For example, combine the domains dataset with the US_addresses dataset with the latitude and longitude dataset in order to graph your data on a map. 

```ruby

  # combine the following 3 datasets

  fn.matches 
    [ ["Dataset1","field1"],
    ["Dataset2", "field1"],
    ["Dataset3", "field1", field2] ]
```
For example: 

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.name "hello_world"
  fn.matches 
    [["Table","url","html"],
    ["US_addresses", "line1, "line2", "city", "state", "country", "zipcode"],
    ["geocoding", "latitude", "longitude"]]
  fn.emits [["hello_world", ["url"]]] 
  
  fn.execute do |tuple, collector| 
    
  url = tuple['url']
  html = tuple['html'] 
  
  if html.include?('hello world')
    controller.emit("join_table", "URL" => url)
    
  end 
  
end 
```

Try the above out by copying it to a Zillabyte directory!




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
