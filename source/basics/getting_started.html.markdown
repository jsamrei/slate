---
title: Getting Started
---

# Getting Started

Zillabyte allows you to write a flow that searches and processes the web.  

Zillabyte assumes familiarity with the command-line and the Ruby language.  Familiarity with both will go a long way in helping users understand why Zillabyte works the way it does.  

## Installation

Zillabyte is distributed using the RubyGems package manager. This means you will need both the Ruby language runtime installed and RubyGems to begin using Zillabyte.

Mac OS X comes prepackaged with both Ruby and Rubygems, however, some of the Zillabyte's dependencies need to be compiled during installation and on OS X that requires Xcode. Xcode can be installed via the [Mac App Store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). Alternately, if you have a free Apple Developer account, you can just install Command Line Tools for Xcode from their [downloads page](https://developer.apple.com/downloads/index.action).

Once you have Ruby and RubyGems up and running, execute the following from the command line:

``` bash
$ gem install zillabyte
```

This will install Zillabyte, its dependencies and the command-line tools for using Zillabyte.

The installation process will add one new command to your environment, with 3 main features:

* zillabyte relations
* zillabyte query
* zillabyte flows

Let's run through each of these three commands and then you'll be on your way to using Zillabyte!

## $ zillabyte relations
### Manage public and custom relations

Relations are essentially tables, or datasets.  To see the relations currently available to you through Zillabyte, run:  

``` bash
$ zillabyte relations
```

Running this command, you will see a table with headers of ID, NAME, SCOPE, STATE, ROWS, COLUMNS, and DESCRIPTION. 

Every Zillabyte user by default can see our web corpus, which has the name 'web_pages'.

For now, to see some of the sample data in a particular dataset:

``` bash
$ zillabyte relations:show 2
```

You will see 20 rows of sample data in the relation with the ID number 2, our web_pages relation.

## $ zillabyte query
### Query data in your relations

Zillabyte allows you to query a relation using the SQL language.  

#### Some examples: 
This command allows you to see sample data in the webpages dataset: 

``` bash
$ zillabyte query:sql "select * from web_pages"
```

This command allows you to see sample data in the webpages dataset which have URLs that have the word hello in it: 

``` bash
$ zillabyte query:sql "select * from web_pages where v0 like '%hello%'"
```

This command allows you to see sample data in the webpages dataset which have HTML of URLs that have the word hello in it:

``` bash
$ zillabyte query:sql "select * from web_pages where v1 like '%hello%'"
```


## $ zillabyte flows
### Write your own algorithm to get the results you want

In order to create your own relation, you will need to run a flow on our servers.  This is a 4 step process: Initializing the function, writing the function, testing the function locally, and then pushing the function to our servers. 

#### Step one: 

``` bash 
zillabyte flows:init ruby demo
```
This initializing command takes two arguments: your language of choice (ruby) and your flow directory (demo).  We support ruby at the moment.  

As an example, this creates a demo directory in the current working directory, with a ruby script. 

#### Step two:

``` bash 
$ cd demo
``` 

Within that directory, you will see a few files.  The important one is your flow: 'simple_function.rb'.

Open 'simple_function.rb' in your text editor of choice.  It has four parts: flow name, input, output, and your algorithm for your flow.  By default, your algorithm looks for html in the webpages relation that includes "hello world".  An HTML search on the web is the simplest thing you can do with Zillabyte.  You can change 'hello world' to be something else, like your name, and to include OR or AND operators, to list a few examples.

```ruby
require 'zillabyte' # Can require any other of your favorite gems 

Zillabyte.simple_function do |fn| # Create a new simple_function
  # A simple_function consists of these 4 Zillabyte methods:
  # name, matches, emits, execute.
  
  # 1 Name your function, using only alphanumeric characters and/or _.
  fn.name "hello_world"

  # 2 What data are you processing?
  # The source of the input tuples that you want to process. 
  # Name the relations and the associated columns of your data. 
  # The relation and column names must be alphanumeric and/or _.
  # Types supported currently are :string, :integer, and :float.
  fn.matches [["domains", ["url", "html"]]] 

  # 3 What do your results look like?
  # The resulting relation.  The relation and column names must
  # be alphanumeric and/or underscore.  Column names cannot be 
  # v[a number], id, confidence, source, or since -- we use these
  # already in our system. 
  fn.emits [["hello_world", ["url"]]] 
    
  # 4 What is your algorithm? 
  # This is the code that is run on each input tuple. For example, 
  # if you are looking for "hello world" in a html column,
  # you would specify that here.  
  fn.execute do |tuple, collector| 
  
    url = tuple['url']
    html = tuple['html'] 
  
    if html.include?('hello world')
      # Write data to your resulting relation.
      controller.emit("hello_world", "URL" => url)
    end
  end 
  
  # That's it!

end 
```

#### Step three: 

```bash 
$ zillabyte test
```

Let us assume you want to look for 'hello world' in HTML.  To quickly test whether this will have results, run the above command.  This will use a local cache of our web corpus and show you a few results. 

#### Step four: 

``` bash
$ zillabyte push
```

Now that you've confirmed some results, push your flow up to our servers, where it will run continously. 

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
