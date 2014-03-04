---
title: Pinterest
---
## Webpages with the substring "pinterest"



``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [["web_page", ["URL", "HTML"]]] 

  fn.emits [["html_has_pinterest", ["URL"]]] 

  fn.execute do |tuple, collector| 

    url = tuple['url'] 
    html = tuple['html'] 


    if html.include?('pinterest') 
      collector.emit("html_has_pinterest",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
