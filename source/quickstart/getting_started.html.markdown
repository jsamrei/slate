---
title: Getting Started
---

# Getting Started

## Setup 

First, [sign up](http://api.zillabyte.com/accounts/sign_up) to get your auth token.  You need an auth token to run your own flow on Zillabyte. 

Second, install the CLI interface, which will give you access to all zillabyte commands. 
For more detailed help, check out the [installation page](/quickstart/installation).

```bash
$ gem install zillabyte
```

Third, authenticate using your auth token. This will prompt you for your auth token.

```bash
$ zillabyte login
```

Now you're ready!

## Hello world for Zillabyte

In the following, we'll guide you through five steps: creating your Zillabyte directory, looking at the code fo your flow, running your flow, viewing the results on our servers, and exporting the data to your local machine. 

#### Create your Zillabyte directory 

```bash
# zillabyte flows:init [your choice of language] [your directory name]
$ zillabyte flows:init ruby helloworld
```
#### The code for the flow 

Within the helloworld directory, you'll find a script called simplefunction.rb.  By default, it searches our domains dataset for URLs that have "hello world" in the HTML.  You'll find that it works right out of the box! 

```ruby
require 'zillabyte' 
# Feel free to add your favorite libraries

# Create a new simple_function
Zillabyte.simple_function do |fn| 
  
  # Name your function
  fn.name "hello_world"

  # Your input data is the domains relation, 
  # which has 2-tuples of URL and HTML.
  fn.matches [
    ["domains", ["url", "html"]]
  ] 

  # What does the resulting relation look like? 
  # Define it here, as a 1-tuple of URL.
  fn.emits [
    ["hello_world", ["url"]]
  ] 
    
  # This is the code that is run on each input tuple.
  # This is where your algorithm, or model goes.
  fn.execute do |tuple, collector| 
  
    url = tuple['url']
    html = tuple['html'] 
  
    if html.scan('hello world')
      controller.emit("hello_world", "URL" => url)
    end
  end 

end 
```

#### Push to our servers in order to run the flow

```bash 
$ zillabyte push
```


#### View the results

``` bash
$ zillabyte relations:show hello_world
```

#### Export the results to your local machine as a gzipped file

```bash
$ zillabyte relations:pull hello_world 
``` 

Now you have a dataset of thousands of websites that have the term "hello world".  Of course, this is trivial.  The power of Zillabyte is the customizability and its flexibility.  

## Next steps

If you haven't already done so, you should try our [tutorial](/tutorial). Next, we recommend checking out our [example apps](/examples/index_commerce).



[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
