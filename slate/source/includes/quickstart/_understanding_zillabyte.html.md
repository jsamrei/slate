# Understanding Zillabyte

Zillabyte is an analysis platform for developers.  It allows developers to focus on building their unique applications instead of low level infrastructure.  

Because it is hosted in the cloud, Zillabyte can handle most of the pitfalls associated with large-scale & distributed analysis.  Further, as a central location of algorithms, Zillabyte allows developers easily build upon others' contributions.  

The central unit in Zillabyte is called a "Data App."  A Data App is a block of code that inputs data, performs one to many operations on it, and then produces a corresponding output.  Data may be [source'd](/quickstart/faq#whats_a_source) and [sink'ed](/quickstart/faq#whats_a_sink) from a variety of locations & formats, including Zillabyte's [Open Datasets](http://zillabyte.com/data), which includes an fresh crawl of the web, patents, etc. 

As a developer, you work in the programming language of your choice.  Currently supported languages are [listed here](/quickstart/faq#what_languages_are_supported).  In this regard, Zillabyte is like a [DSL](/quickstart/faq#what_is_a_dsl):  you code in any supported language, but you must code in a way that Zillabyte can understand.  This is known as the [Pipe Programming Paradigm](http://blog.zillabyte.com/2014/05/14/the-pipe-programming-paradigm/), and it allows Zillabyte to scale & modularize your code.  

Most of your work will be on your local machine as you iterate and build your Data App.  When you are ready to run at scale, you use the Zillabyte CLI to push your code to the cloud.  A typical workflow includes these steps: 

1. Code an App in your favorite language on your local computer.
1. Test your code locally using the `zillabyte test` command.
1. Push your App to Zillabyte, where Zillabyte executes your app at scale. 
1. Upon completion, download the output data of your App. 

## Interacting with Zillabyte

The gateway to Zillabyte is the Command Line Interface (CLI).  The CLI is a tool you install on your local machine by executing: 

`$ gem install zillabyte `

Once installed, you'll need to authenticate your account by running `zillabyte login`.  If you haven't done so, create an account at [zillabyte.com/register](http://app.zillabyte.com/register) and retrieve your [auth_token](/faq#whats_an_auth_token). 

The CLI has a variety of commands to manage your Data Apps.  However, the two you'll use the most are `zillabyte apps` and `zillabyte data`.  

## Pipe Programming

When you build a Data App, you must code in the [Pipe Programming Paradigm](http://blog.zillabyte.com/2014/05/14/the-pipe-programming-paradigm/).  The Pipe Programming Paradigm is a DSL that allows Zillabyte to modularize and scale your code.  In other words, you code in your favorite language, but you need use special programming patterns to take advantage of Zillabyte. 

The crux of this paradigm is that you defer loops to the Zillabyte framework as much as possible.  That is, instead of coding an explicit `for` loop that iterates over, say, millions of tuples, you will instead use Zillabyte's corresponding `each` method.  The `each` method allows Zillabyte to run the inner block of your iterator to multiple machines.

For more information, refer to the [Pipe Programming Paradigm documentation](http://blog.zillabyte.com/2014/05/14/the-pipe-programming-paradigm/).

## Accessing Data 

In addition to running your Data Apps, Zillabyte can also store your data in the cloud.  This feature is generally used to temporarily store the input & output data of a Data App.  You can upload, download, and query your data using the `zillabyte data` sub command. 

One important concept is the notion of a [shard](/quickstart/faq#what_is_a_shard).  A shard is subset of a dataset when the entire dataset will not reasonably fit into a single file.  Zillabyte will usually start sharding datasets when the total size surpasses a few megabytes.  

