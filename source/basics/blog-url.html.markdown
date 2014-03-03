---
title: Blog URLs
---
## URLs with the substring "blog"

``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [["web_page", ["URL", "HTML"]]] 

  fn.emits [["url_has_blog", ["URL"]]] 

  fn.execute do |tuple, collector| 

    url = tuple['url'] 
    html = tuple['html'] 


    if url.include?('blog') 
      collector.emit("url_has_blog",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```


In the above, zillabyte.simple_function defines a new simple flow which is stored in fn. 

fn.name will define a name for the flow (this is optional, but makes testing easier as running zillabyte live_run [name] will allow you to test the function interactively). 

fn.emits defines the relations that the function should emit. These are given in a list. Each relation is then given as a list as well, where the first element is the relation name and the second element is yet another list of the field names for that relation. 

fn.prepare executes any prep work required before the function runs. 

fn.execute includes code that the actual function is meant to execute. The results of execute are emitted by the collector which has a collector.emit method. This method takes in the relation name as the first argument, the tuple to be emited as the second argument and the meta data as an optional third argument. The tuple must be specified in hash format with keys being the fields of the relations specified in "emits" and values being the relevant values computed by the function. The meta fields are optional. Users can specify the confidence of their results (as a float), the timestamp of their results in Java format and the source of the results as a string. If no meta fields are specified, they are defaulted to 1.0, current time and empty string.


[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
