---
title: Hello Worlds in Silicon Valley
---

## Hello Worlds in Silicon Valley: Ruby script

``` bash
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.matches [ 
              ``["web_page", ["URL", "HTML"] 
              ["company_of", ["URL", "COMPANY"]] 
              ["location_of", ["COMPANY", "LAT", "LNG"]] 
              ["between", ["LAT", 37.3, 37.8]] 
              ["between", ["LNG", -121.8, -122.4]] 
              ] 
              
  fn.emits [["has_hello_world", ["URL"]]] 

  fn.execute do |tuple, collector|

    url = tuple['url'] 
    html = tuple['html'] 


    if html.include?('hello world') 
      collector.emit("has_hello_world",{"url" => url},{"confidence" => 1., "since" => Time.now.to_java, "source" => "") 
    end 

  end 

end
```

The above code is exactly the same as in the previous Hello Worlds example except instead of matches querying from just a single table, it queries from a number of tables ("web_page", "company" and "location") and joins the results. The results are joined on the columns with the same name. The function "between" just finds all of the LAT and LNG between the specified coordinates.

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
