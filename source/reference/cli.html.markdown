---
title: CLI Reference
---

## zillabyte CLI

The command line interface (CLI) is the primary way to interact with the Zillabyte infrastructure.  Details of each command can be viewed by running `zillabyte COMMAND --help`.  The standalone `help` command is also a quick way to see the available commands.

  ``` bash
  $ zillabyte help
  Usage: zillabyte COMMAND [command-specific-options]
  
  Primary help topics, type "zillabyte help TOPIC" for more details:
  
    apps      #  manage custom apps
    query     #  executes queries
    relations #  manage custom relations
  
  ...
  ```

### Apps

Apps are the core data pipeline that defines the stages of processing the data. See --this help doc-- for an overview of apps. 

  ```bash
  $ zillabyte help apps

  apps                      #  list custom apps
  apps:cycles ID [OPTIONS]  #  operations on the app's cycles (batches).
  apps:delete ID            #  deletes a app. if the app is running, this command will kill it.
  apps:info [DIR]           #  outputs the info for the app in the dir.
  apps:init [LANG] [DIR]    #  initializes a new executable in DIR
  apps:kill ID              #  kills the given app
  apps:logs FLOW_ID         #  streams logs from the distributed workers
  apps:prep [DIR]           #  prepares a app for execution
  apps:pull ID DIR          #  pulls a app source to a directory.
  apps:push [DIR]           #  uploads a app
  apps:test [RELATION_ID]   #  tests a local app with sample data

  ```

### Relations

Data in the zillabyte infrastructure is saved by default as relations (tables in an RDBMS). 

  ```bash
  $ zillabyte help relations
  
  relations                                        #  lists your custom relations
  relations:append ID FILE                         #  adds data to an existing relation
  relations:create NAME                            #  creates a new relation
  relations:delete ID                              #  deletes a relation
  relations:pull ID OUTPUT                         #  pulls relation data into OUTPUT.gz
  relations:pull:s3 ID KEY SECRET BUCKET FILE_KEY  #  pulls relation data to S3_BUCKET/FILE_KEY/part***.gz
  relations:show ID                                #  shows raw data in a relation. run 'queries' for more elaborate functionality
  ```

### Query

Use the query command to look at sample results from relations visible to you.

  ```bash
  $ zillabyte help query

  query:pull:s3 QUERY KEY SECRET BUCKET FILE_KEY  #  pulls query data to S3_BUCKET/FILE_KEY/part***.gz
  query:sql EXPRESSION                            #  executes queries against the zillabyte corpus
  query:sxp EXPRESSION                            #  executes queries against the zillabyte corpus
  ```

### Aliases

The following aliases redirect to the commands to reduce keystrokes.

  ```bash
  $ zillabyte help aliases

  login    --> auth:login       #  Sets the Zillabyte Auth token
  logout   --> auth:logout      #  Sets the Zillabyte Auth token
  info     --> apps:info        #  outputs the info for the app in the dir.
  logs     --> apps:logs        #  streams logs from the distributed workers
  prep     --> apps:prep        #  prepares a app for execution
  pull     --> apps:pull        #  pulls a app source to a directory.
  push     --> apps:push        #  uploads a app
  test     --> apps:test        #  tests a local app with sample data
  sql      --> query:sql        #  executes queries against the zillabyte corpus
  sxp      --> query:sxp        #  executes queries against the zillabyte corpus
  append   --> relations:append #  adds data to an existing relation
  ```

For detailed help on each alias, type `zillabyte help ALIAS`.

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
