---
title: Search specific HTML elements
---
## Search specific HTML elements

Most search engines provide unstructured search.  Zillabyte provides helper functions to search specific HTML elements.

```ruby
  # Search only through a specific tag
  if HTML.includes('HTML_TAG')
```


For example, Javascript tags. Other options include comment fields, text areas, paragraph elements, etc.

```ruby
require 'zillabyte'


Zillabyte.simple_function do |fn| 

  fn.name "hello_world"
  fn.matches [["domains", "url", "html"]]
  fn.emits [["hello_world", ["url"]]] 
  
  fn.execute do |tuple, collector| 
    
  url = tuple['url']
  html = tuple['html'] 
  
  if html.script.include?('zillabyte.js')
    controller.emit("hello_world", "URL" => url)
    
  end 
  
end 
```

Try the above out by copying it to a Zillabyte directory!




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
