---
title: Twitter
---
## Webpages with the substring "twitter"



``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [["web_page", ["URL", "HTML"]]] 

  fn.emits [["html_has_twitter", ["URL"]]] 

  fn.execute do |tuple, collector| 

    url = tuple['url'] 
    html = tuple['html'] 


    if html.include?('twitter') 
      collector.emit("html_has_twitter",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
