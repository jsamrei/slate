---
title: FAQ
---

# Zillabyte FAQ

## What is Zillabyte? What can I create using Zillabyte?

Zillabyte makes it easy to build data applications that scale. Using Zillabyte, you can process large datasets, including provided datasets such as the content of the web. Applications can be created in common languages such as Ruby or Python, and run on Zillabyte servers in the cloud.

## How do I install Zillabyte?

Zillabyte uses a command utility (the Zillabyte CLI) in order to interact with our servers, this application is written in Ruby. Installation instructions can be found at the [installation](/quickstart/installation) page.

## How do I use Zillabyte?

To use the Zillabyte CLI, run the `zillabyte` command from your terminal. A simple usage of Zillabyte involves two topics: `relations`, which are the datasets to process, and applications(`apps`), which are run in order to process and transform relations. 

To begin, run `zillabyte help` to see the list of available commands that you can use for your Zillabyte projects.

## What data is available for me to use in a Zillabyte App?

We are making some useful datasets publicly accessible for you to quickly get started. The first ones we are providing are `domains` and `web_pages`. The `domains` dataset contains more than 50 million domains. The `web_pages` dataset contains a sample of a deep web crawl, consisting for more than 5 million urls, with ther html content.

In addition, you can upload your own datasets into Zillabyte, for traditional data processing sped up by Zillabyte.

## How do I get data into the Zillabyte ecosystem?

### Web data

A sample of web date already exists in relations for your app to source. See the [hello_world](/quickstart/hello_world) example for an explanation of sourcing from the `web_pages` relation.

### Static data

To upload your own datasets into Zillabyte, a relation first must be created to hold the data. Run the `zillabyte relations:create NAME` function to create a new relation with the name NAME. This command allows you to define the schema of the relation or directly upload a dataset during the creation.

To add CSV datasets to a relation, use the `relations:append` function. 

Csv files should be uploaded using the CLI `relations:append ID FILE` function. This appends the file FILE to the relation with an id(or name) ID. Once this relation has been populated with data, it can be sourced in the same manner as web data.

### Streaming data

To input data into an app that is continously changing, use the source feature of the app to pull in data. You can define run cycles of an application, in order to periodically check data sources for new entries. Refer to the [apps](/quickstart/apps) guide for information on custom sources.


  
## How do I view or get data out of the Zillabyte ecosystem?

### Viewing data

Running the `zillabyte relations` command will allow you to view your relations. Running the `zillabyte relations:show ID` command using the id or name of your relation will show a sample subset of your the relation's data. 

In addition, Zillabyte relations can be queried using standard SQL via the `zillabyte sql` command. A sample command may look like `zillabyte sql 'select * from web_pages`. 

### Downloading the entire result set

To pull a relation data set to your local machine, call the `zillabyte relations:pull ID OUTPUT` command. This command downloads the relation identified by ID into the file OUTPUT.gz (the default filetype is a CSV). 

Relations can also be pulled into your specified directory on Amazon S3 for further integration with other cloud based applications. To do so, use the `zillabyte relations:pull:s3` command.


[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
