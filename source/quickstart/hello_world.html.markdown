---
title: Hello, World!
---

# Hello, World!

This page demonstrates the simple steps to search for occurences of the phrase 'hello world' in our open dataset, `web_pages`.  The `web_pages` corpus represents a crawled subset of the web.  It is crawled every week or so by Zillabyte and contains a few million pages of the most popular sites on the web.  

Before getting started, be sure to register and [install the Zillabyte CLI](/quickstart/installation) by running: 

```bash
# install the CLI
$ gem install zillabyte

# register
$ zillabyte login
```

## Initialize the Data App

```bash
$ zillabyte apps:init hello_world_app
```

This command will create a new directory with the necessary files to run the app.  By default, the app is initialized in Ruby, although you are free to use other languages as well.  Run `zillabyte init --help` for more options. 
 
## App Code

The code for the Data App is as follows: 

```ruby
require 'zillabyte' 

app = Zillabyte.app("hello_world_app")
  .source("web_pages")
  .each{ |page|
    if page['html'].include? "hello" #  world
      emit :url => page['url']
    end
  }
  .sink{
    name "has_hello_world"
    column "url", :string
  }
```

The `source("web_pages")` line indicates that the App should read all data from the `web_pages` corpus.  The `web_pages` corpus is an open dataset and is publicly available to everyone.  However, you could just as easily swap out this dataset for another. 

The next segment is the `each` block.  This is the heart of this particular algorithm.  This block will execute on every tuple produced by the previous `source`.  In this case, we're going to consume every web page in the `web_pages` corpus and simply detect if the phrase "hello world" exists on the page.  If so, then we will `emit` the URL of the page back into the stream.

Tuples emitted from the `each` block are then sent to the `sink`.  As the name implies, the `sink` is where tuples are persisted to the Zillabyte data store.  Data the flows into the `sink` can be inspected with the `zillabyte data` sub command. 


## Push to the Cloud

```bash 
$ zillabyte push
```

![Zillabyte simple apps](/images/HelloWorld.png)

When the app is pushed, Zillabyte will automatically scale the code across a cluster of machines.  Zillabyte does this by inspecting the operations (`source`, `each`, `sink`) and instantiating multiple instances of each one, depending on data volume. 

Once the app has been pushed, you may want to see the log output.  This is a convenient way to debug and inspect the status of your app. 

```bash
$ zillabyte logs
```

## View the Results 

When the app has finished, you are free to take the output dataset.  To quickly view a sampling of the data, run the following: 

``` bash
$ zillabyte data:show has_hello_world
```

More likely, however, you will want to download the data to your local machine.  In that case, run the following: 

```bash
$ zillabyte data:pull has_hello_world output.gz
``` 
 
## Next Steps

The above Data App is fairly simple.  However, it demonstrates how quickly one can tap into the distributed analysis on large datasets, such as the web.  It is hopefully obvious how the above app can be expanded to do more elaborate analysis on the web. 

For a list of more examples, please refer to [docs.zillabyte.com](/)
