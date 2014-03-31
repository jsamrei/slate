---
title: CLI Reference
---

## zillabyte CLI

The command line interface allows you to interact with our infrastructure. Access these commands by typing "zillabyte COMMAND". The help command is an easy way to refer to this the documentation on this page.

  ``` bash
  $ zillabyte help
  Usage: zillabyte COMMAND [command-specific-options]
  
  Primary help topics, type "zillabyte help TOPIC" for more details:
  
    flows      #  manage custom flows
    query      #  executes queries
    relations  #  manage custom relations
  
  ...
  ```

### Flows

Flows are the core data pipeline that defines the stages of processing the data. See --this help doc-- for an overview of flows. 

  ```bash
  $ zillabyte help flows

  flows                      #  list custom flows
  flows:cycles ID [OPTIONS]  #  operations on the flow's cycles (batches).
  flows:delete ID            #  deletes a flow. if the flow is running, this command will kill it.
  flows:info [DIR]           #  outputs the info for the flow in the dir.
  flows:init [LANG] [DIR]    #  initializes a new executable in DIR
  flows:kill ID              #  kills the given flow
  flows:logs FLOW_ID         #  streams logs from the distributed workers
  flows:prep [DIR]           #  prepares a flow for execution
  flows:pull ID DIR          #  pulls a flow source to a directory.
  flows:push [DIR]           #  uploads a flow
  flows:test [RELATION_ID]   #  tests a local flow with sample data

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

For the common commands, use the following aliases to reduce keystrokes.

  ```bash
  $ zillabyte help aliases

  login                --> auth:login             #  Sets the Zillabyte Auth token
  logout               --> auth:logout            #  Sets the Zillabyte Auth token
  info                 --> flows:info             #  outputs the info for the flow in the dir.
  logs                 --> flows:logs             #  streams logs from the distributed workers
  prep                 --> flows:prep             #  prepares a flow for execution
  pull                 --> flows:pull             #  pulls a flow source to a directory.
  push                 --> flows:push             #  uploads a flow
  test                 --> flows:test             #  tests a local flow with sample data
  sql                  --> query:sql              #  executes queries against the zillabyte corpus
  sxp                  --> query:sxp              #  executes queries against the zillabyte corpus
  append               --> relations:append       #  adds data to an existing relation
  ```

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
