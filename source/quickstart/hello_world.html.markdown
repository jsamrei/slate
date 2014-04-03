---
title: Hello, World!
---

# Hello, World!

Zillabyte makes it easy to build data applications that scale. This page demonstrates the simple steps to search for occurences of 'hello world' in our corpus of web pages. To reproduce these commands on your machine, make sure you follow the steps on the [installation](/installation) page.

## Initialize your app

```bash
$ zillabyte apps:init
```
Executing this command in an empty folder will place three files. 
 
## The code 

The entire code for the hello world data app follows: 

```ruby
require 'zillabyte' 

Zillabyte.simple_function do 
  
  name "hello_world"

  matches "select * from web_pages"

  emits [
    ["hello_world", [{"url"=>:string}]]
  ] 
    
  execute do |tuple| 
    url = tuple['url']
    html = tuple['html'] 
    if html.scan('hello world')
      emit("hello_world", "URL" => url)
    end
  end 

end 
```


## Push to our servers in order to run the app

```bash 
$ zillabyte push
```


## View the results

``` bash
$ zillabyte relations:show hello_world
```

## Export the results to your local machine as a gzipped file

```bash
$ zillabyte relations:pull hello_world 
``` 

Now you have a dataset of thousands of websites that have the term "hello world".  Of course, this is trivial.  The power of Zillabyte is the customizability and its flexibility.  

 
## Next steps

If you haven't already done so, you should try our [tutorial](/tutorial). Next, we recommend checking out our [example apps](/examples/index_commerce).



[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
