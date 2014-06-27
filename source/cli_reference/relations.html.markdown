
## Relations

Relations are the method for data storage and retrieval within Zillabyte. See the [Quickstart - FAQ](/quickstart/faq) for more information on relations.

``` bash
Usage: zillabyte relations

 lists your custom relations
 --output_type OUTPUT_TYPE                   # specify an output type i.e. json


  relations                     #  lists your custom relations
  relations:append              #  adds data to an existing relation
  relations:create              #  creates a new relation
  relations:delete              #  deletes a relation
  relations:pull                #  pulls relation data into OUTPUT.gz
  relations:pull:s3             #  pulls relation data into S3
  relations:show                #  shows a sample of the data in a relation.
```

### relations:append 
```bash
$ zillabyte relations:append 
Usage: zillabyte relations:append ID FILE

 adds data to an existing relation
 --filetype FILETYPE                 # Input File format type, defaults to csv
 --output_type OUTPUT_TYPE                     # Output formatting type i.e. json

``` 

### relations:create 

```bash

$ zillabyte relations:append 
Usage: zillabyte relations:create NAME

 creates a new relation

 --schema SCHEMA              # Column names and types in the format "field_1:output_type_1,field_2:output_type_2,..."
 --public SCOPE               # Make the relation public
 --file FILE                  # A data file
 --filetype FILETYPE          # File format type, defaults to csv
 --description DESCRIPTION    # Description of relation contents
 --aliases ALIASES            # Relation name aliases in the format "alias_1,alias_2,..."
 --output_type OUTPUT_TYPE                  # The output format type

```
### relations:delete

```bash
$ zillabyte relations:delete 
Usage: zillabyte relations:delete ID

 deletes a relation

 -f, --force         # Delete without asking for confirmation
 --output_type OUTPUT_TYPE     # The output format type

```
### relations:pull   

```bash

$ zillabyte relations:pull 
Usage: zillabyte relations:pull ID OUTPUT

 pulls relation data into OUTPUT.gz

  --cycle_id [cycle_id]              # retrieve data generated for that cycle, only if this relation is associated with an app. (defaults to the last cycle
  --output_type OUTPUT_TYPE                        # specify a communication format (i.e json) for programmatic interaction
```
### relations:pull:s3

```bash

$ zillabyte relations:pull:s3 
Alias: relations:pull:s3 redirects to relations:pull_to_s3
Usage: zillabyte relations:pull:s3 ID S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY

 pulls relation data to S3_BUCKET/FILE_KEY/part***.gz

  --cycle_id [cycle_id]                                # retrieve data generated for that cycle, only if this relation is associated with an app. (defaults to the last cycle)
  -t, --output_type OUTPUT_TYPE                                      # the output format types

```
### relations:show   

```bash
$ zillabyte relations:show 
Usage: zillabyte relations:show ID

 shows a sample of the data in a relation. see 'zillabyte queries' for more elaborate functionality

  --cycle_id [cycle_id]   # retrieve data generated for that cycle, only if this relation is associated with an app. (defaults to the last cycle)
  --no_truncation         # don't truncate long strings
  --output_type OUTPUT_TYPE             # the type of the output

```


