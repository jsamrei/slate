---
title: Getting Started
---

# Getting Started

Zillabyte allows you to write a flow that processes the web. 

Zillabyte assumes familiarity with the command-line.  Familiarity with both will go a long way in helping users understand why Zillabyte works the way it does.

## Installation

Zillabyte is distributed using the RubyGems package manager. This means you will need both the Ruby language runtime installed and RubyGems to begin using Zillabyte.

Mac OS X comes prepackaged with both Ruby and Rubygems, however, some of the Middleman's dependencies need to be compiled during installation and on OS X that requires Xcode. Xcode can be installed via the [Mac App Store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). Alternately, if you have a free Apple Developer account, you can just install Command Line Tools for Xcode from their [downloads page](https://developer.apple.com/downloads/index.action).

Once you have Ruby and RubyGems up and running, execute the following from the command line:

``` bash
gem install zillabyte
```

This will install Zillabyte, its dependencies and the command-line tools for using Zillabyte.

The installation process will add one new command to your environment, with 3 main features:

* zillabyte relations
* zillabyte query
* zillabyte flows

The uses of each of these commands will be covered below.

## zillabyte relations: datasets available to you

To see the datasets currently available to you through Zillabyte, run:  

``` bash
zillabyte relations
```

Running this command, you will see a table with headers of ID, NAME, SCOPE, STATE, ROWS, COLUMNS, and DESCRIPTION.  These will be described in detail further in the documentation.

Every Zillabyte user by default can see our web corpus, which has the name 'web_pages'.

For now, to see some of the sample data in a particular dataset:

``` bash
zillabyte relations:show ID
```

## zillabyte query: query the available data

Zillabyte allows you to query a dataset using the SQL language.  

### Some examples: 
This command allows you to see sample data in the webpages dataset: 

``` bash
zillabyte query:sql "select * from web_pages"
```

This command allows you to see sample data in the webpages dataset which have URLs that have the word hello in it: 

``` bash
zillabyte query:sql "select * from web_pages where v0 like '%hello%'"
```

This command allows you to see sample data in the webpages dataset which have HTML of URLs that have the word hello in it:

``` bash
zillabyte query:sql "select * from web_pages where v1 like '%hello%'"
```


## zillabyte flows: create your own dataset

In order to create your own dataset, you will need to run a flow on our servers.  This is a 4 step process: Initializing the function, writing the function, testing the function locally, and then pushing the function to our servers. 

### Step one: 

``` bash 
zillabyte flows:init ruby demo
```
This initializing command takes two arguments: your language of choice, and where you would like store your flow.  We support ruby, python, and javascript at the moment.  

As an example, this creates a demo directory in the current working directory, with a ruby script. 

### Step two:

``` bash 
cd demo
``` 

``` bash 
ls
```

Change into that directory, and look around.

You will see a few files.  The important one is your flow: 'simple_function.rb'.

Open 'simple_function.rb' in your text editor of choice.  It has three parts: input, output, and your algorithm for your flow.  By default, your algorithm looks for html in the webpages relation that includes "hello world".  An HTML search on the web is the simplest thing you can do with Zillabyte.  You can change 'hello world' to be something else, like your name, and to include OR or AND operators, to list a few examples.

### Step three: 

```bash 
zillabyte test
```

Let us assume you want to look for 'hello world' in HTML.  To quickly test whether this will have results, run the above command.  This will use a local cache of our web corpus and show you a few results. 

### Step four: 

``` bash
zillabyte push
```

Now that you've confirmed some results, push your flow up to our servers, where it will run continously. 

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
