---
title: Your name
---
## Webpages with the substring "your name"

``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [["web_page", ["URL", "HTML"]]] 

  fn.emits [["has_hello_world", ["URL"]]] 

  fn.execute do |tuple, collector| 

    url = tuple['url'] 
    html = tuple['html'] 


    if html.include?('your name') 
      collector.emit("has_hello_world",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```


[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
