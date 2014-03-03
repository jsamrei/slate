---
title: Hello World URLs
---
## URLs with the substring "hello world"

``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [["web_page", ["URL", "HTML"]]] 

  fn.emits [["url_has_hello_world", ["URL"]]] 

  fn.execute do |tuple, collector| 

    url = tuple['url'] 
    html = tuple['html'] 


    if url.include?('hello world') 
      collector.emit("url_has_hello_world",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```



[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
