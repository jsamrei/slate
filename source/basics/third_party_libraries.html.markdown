---
title: Use your favorite libraries
---
## Use your favorite libraries

Zillabyte empowers developers to search the web the way they want.  This includes using your favorite libraries.  Currently, we support the Ruby language; thus you can use any Ruby gem in your flow. 

```ruby
  require 'zillabyte'
  require 'YOURGEM'
```
For example: 

```ruby
require 'zillabyte'
# For URI Parsing
require 'uri'
require 'open-uri'


Zillabyte.simple_function do |fn| 

  fn.name "hello_world"
  fn.matches [["domains", "url", "html"]]
  fn.emits [["hello_world", ["url"]]] 
  
  fn.execute do |tuple, collector| 
    
  url = tuple['url']
  html = tuple['html'] 
  
  if html.include?('hello world')
    controller.emit("hello_world", "URL" => url)
    
  end 
  
end 
```

Try the above out by copying it to a Zillabyte directory!




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
