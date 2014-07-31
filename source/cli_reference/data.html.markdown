
## Data

The `data` command allows you to fully interact with datasets stored in Zillabyte.  See the [Quickstart - FAQ](/quickstart/faq) for more information.

``` bash
Usage: zillabyte data

 lists your custom datasets
 --output_type OUTPUT_TYPE                   # specify an output type i.e. json


  data                     #  lists your custom datasets
  data:append              #  adds data to an existing dataset
  data:create              #  creates a new dataset
  data:delete              #  deletes a dataset
  data:pull                #  pulls dataset data into OUTPUT.gz
  data:pull:s3             #  pulls dataset data into S3
  data:show                #  shows a sample of the data in a dataset.
```

### data:append 
```bash
$ zillabyte data:append 
Usage: zillabyte data:append ID FILE

 adds data to an existing dataset
 --filetype FILETYPE                 # Input File format type, defaults to csv
 --output_type OUTPUT_TYPE                     # Output formatting type i.e. json

``` 

### data:create 

```bash

$ zillabyte data:append 
Usage: zillabyte data:create NAME

 creates a new dataset

 --schema SCHEMA              # Column names and types in the format "field_1:output_type_1,field_2:output_type_2,..."
 --public SCOPE               # Make the dataset public
 --file FILE                  # A data file
 --filetype FILETYPE          # File format type, defaults to csv
 --description DESCRIPTION    # Description of dataset contents
 --aliases ALIASES            # Dataset name aliases in the format "alias_1,alias_2,..."
 --output_type OUTPUT_TYPE                  # The output format type

```
### data:delete

```bash
$ zillabyte data:delete 
Usage: zillabyte data:delete ID

 deletes a dataset

 -f, --force         # Delete without asking for confirmation
 --output_type OUTPUT_TYPE     # The output format type

```
### data:pull   

```bash

$ zillabyte data:pull 
Usage: zillabyte data:pull ID OUTPUT

 pulls dataset data into OUTPUT.gz

  --cycle_id [cycle_id]              # retrieve data generated for that cycle, only if this dataset is associated with an app. (defaults to the last cycle
  --output_type OUTPUT_TYPE                        # specify a communication format (i.e json) for programmatic interaction
```
### data:pull:s3

```bash

$ zillabyte data:pull:s3 
Alias: data:pull:s3 redirects to data:pull_to_s3
Usage: zillabyte data:pull:s3 ID S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY

 pulls data to S3_BUCKET/FILE_KEY/part***.gz

  --cycle_id [cycle_id]                                # retrieve data generated for that cycle, only if this dataset is associated with an app. (defaults to the last cycle)
  -t, --output_type OUTPUT_TYPE                                      # the output format types

```
### data:show   

```bash
$ zillabyte data:show 
Usage: zillabyte data:show ID

 shows a sample of the data in a dataset. see 'zillabyte queries' for more elaborate functionality

  --cycle_id [cycle_id]   # retrieve data generated for that cycle, only if this dataset is associated with an app. (defaults to the last cycle)
  --no_truncation         # don't truncate long strings
  --output_type OUTPUT_TYPE             # the type of the output

```


