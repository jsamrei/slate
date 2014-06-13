---
title: Hello, World!
---

# Hello, World!

Zillabyte makes it easy to build data applications that scale. This page demonstrates the simple steps to search for occurences of 'hello world' in our corpus of web pages. To reproduce these commands on your machine, make sure you follow the steps on the [installation](/quickstart/installation) page.

## Initialize your app

```bash
$ zillabyte apps:init
```
Executing this command in an empty folder will place three files. 
 
## The code 

The entire code for the hello world data app follows: 

```ruby
require 'zillabyte' 

app = Zillabyte.app("hello_world_app")
  .source("select * from web_pages")
  .each{ |page|
    if page['html'].include? "hello" #  world
      emit :url => page['url']
    end
  }
  .sink{
    name "has_hello"
    column "url", :string
  }
```


## Push to our servers to run the app

```bash 
$ zillabyte push
```

![Zillabyte simple apps](/images/HelloWorld.png)

When an app is pushed to our service, we run the `each` block of code across our compute cluster. Each row of the results of the `source` query are streamed into them. This simple data app will process the millions of web pages in our corpus looking for the words 'hello world' anywhere in the page. The results are then sinked (saved) to a relation called "has_hello_world". The relation has one column, a url (string). 

## View the results

``` bash
$ zillabyte relations:show hello_world
```

## Export the results to your local machine as a zipped file

```bash
$ zillabyte relations:pull hello_world 
``` 

Now you have a dataset of thousands of websites that have the term "hello world".  Of course, this is trivial.  The power of Zillabyte is the customizability and its flexibility.  

 
## Next steps

If you haven't already done so, you should try our [tutorial](/quickstart/tutorial). Next, we recommend checking out our [example apps](/examples/index_commerce).
  
