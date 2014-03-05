---
title: CLI Reference
---

## zillabyte relations



  ``` bash
  zillabyte relations
  ```

  List all of your custom relationships


  ``` bash
  zillabyte relations:append [data_set_id] [file_name]
  ```

  Uploads a new file and appends it to the dataset indicated by the id.


  ``` bash
  zillabyte relations:create [name]
  ```

  Creates a new relation with the specified name.


  ``` bash
  zillabyte relations:delete [data_set_id]
  ```

  Deletes a relation specified by the id.


  ``` bash
  zillabyte relations:pull [data_set_id] [output]
  ```

  Pulls relation data into output


  ``` bash
  zillabyte relations:pull:s3 [data_set_id] [s3_key] [s3_secret] [s3_bucket] [s3_file_path]
  ```

  Pulls relation data into the specified Amazon S3 bucket at the specified file path


  ``` bash
  zillabyte relations:show [data_set_id]
  ```

  Shows the raw data in a relation, use the query interface above for more specific data sets


  ``` bash
  zillabyte relations:status [data_set_id]
  ```

  Shows the current execution state of the specified relation


## zillabyte query

``` bash
  zillabyte query:sql [command]
  ```

  Executes the SQL query in command against Zillabyte data.


  ``` bash
  zillabyte query:sxp [command]
  ```

  Executes the sxp query in command against Zillabyte data.



## zillabyte flows

``` bash
  zillabyte flows
  ```

  List of all flows defined by the user


  ``` bash
  zillabyte flows:info
  ```

  Returns and displays the flow metadata


  ``` bash
  zillabyte flows:live_run [operation_name]
  ```

  Executes the flow operation


  ``` bash
  zillabyte flows:push
  ```

  Deploys the flow to the Zillabyte system where it is then executed. This is similar to `git push` to deploy your own scripts to a server.


  ``` bash
  zillabyte flows:pull [flow_id] [directory]
  ```

  Retrieves and loads the flow corresponding to flow_id into the local directory. This is similar to `git pull` to retrieve the latest code from a repository.


  ``` bash
  zillabyte flows:test [data_set_id]
  ```

  Tests the flow locally. This allows you to specify and test using a custom dataset. This is useful for prototyping and testing assumptions about the queries you build.


  ``` bash
  zillabyte flows:status [flow_id]
  ```

  Gets the status of the specified flow.


  ``` bash
  zillabyte flows:kill [flow_id]
  ```

  Stops the execution of a flow process with the specified id.

## zillabyte data



  ```bash
  zillabyte data
  ```

  List of all datasets uploaded by the user.


  ```bash 
  zillabyte data:create [data_set_name]
  ```

  Creates a new dataset with the provided name on the Zillabyte system.


  ```bash
  zillabyte data:append [data_set_id] [file_name]
  ```

  Uploads a new file and appends it to the dataset indicated by the id.


  ```bash
  zillabyte data:show [data_set_id]
  ```

  Retrieves the first few rows of the specified data set and displays them to user. This is useful to spot check datasets or to ensure you have the right ones available.


  ```bash
  zillabyte data:test [data_set_name] [file_name]
  ```

  Uploads a user-defined test dataset for testing flows.




  ``` bash
  zillabyte data
  ```

  List of all datasets uploaded by the user.


  ``` bash
  zillabyte data:create [data_set_name]
  ```

  Creates a new dataset with the provided name on the Zillabyte system.


  ``` bash
  zillabyte data:append [data_set_id] [file_name]
  ```

  Uploads a new file and appends it to the dataset indicated by the id.


  ``` bash
  zillabyte data:show [data_set_id]
  ```

  Retrieves the first few rows of the specified data set and displays them to user. This is useful to spot check datasets or to ensure you have the right ones available.


  ``` bash
  zillabyte data:test [data_set_name] [file_name]
  ```

  Uploads a user-defined test dataset for testing flows.




[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
