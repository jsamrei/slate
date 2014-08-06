
## Data

The `data` command allows you to fully interact with datasets stored in Zillabyte.  See the [Quickstart - FAQ](/quickstart/faq) for more information.

``` bash
$ zillabyte help data
Usage: zillabyte data

 Lists your custom datasets.

  data                     #  Lists your custom datasets.
  data:append ID FILE      #  Adds data to an existing dataset.
  data:create NAME         #  Creates a new dataset.
  data:delete ID           #  Deletes a dataset.
  data:pull ID OUTPUT      #  Pulls dataset into OUTPUT.gz.
  data:pull:s3 ID S3_PATH  #  Pulls dataset to s3_bucket/s3_key/part***.gz using the given s3_access and s3_secret credentials.
  data:show ID             #  Shows a sample of the dataset. See 'zillabyte queries' for
```

### data:append 

```bash
$ zillabyte help data:append 
Usage: zillabyte data:append ID FILE

 Adds data to an existing dataset.

 --filetype FILETYPE                         # Input File format type, defaults to csv
``` 

### data:create 

```bash
$ zillabyte help data:create
Usage: zillabyte data:create NAME

 Creates a new dataset.

 --schema SCHEMA                             # Column names and types in the format "field_1:output_type_1,field_2:output_type_2,..."
 --public SCOPE                              # Make the dataset public
 --file FILE                                 # A data file
 --filetype FILETYPE                         # File format type, defaults to csv
 --description DESCRIPTION                   # Description of dataset contents
 --aliases ALIASES                           # Dataset name aliases in the format "alias_1,alias_2,..."
```

### data:delete

```bash
$ zillabyte help data:delete 
Usage: zillabyte data:delete ID

 Deletes a dataset.

 -f, --force                                 # Delete without asking for confirmation
```
### data:pull   

```bash
$ zillabyte help data:pull
Usage: zillabyte data:pull ID OUTPUT

 Pulls dataset into OUTPUT.gz.

 --cycle_id [cycle_id]                       # Retrieve data generated during specified cycle if dataset is associated with an app [default: last cycle]
```

### data:pull:s3

```bash
$ zillabyte help data:pull:s3 
Alias: data:pull:s3 redirects to data:pull_to_s3
Usage: zillabyte data:pull:s3 ID S3_PATH

 Pulls dataset to s3_bucket/s3_key/part***.gz using the given s3_access and s3_secret credentials.
 S3_PATH may be given in the following forms:
   1) s3://s3_access:s3_secret@s3_bucket/s3_key
   2) s3://s3_bucket/s3_key: also supply --s3_access and --s3_secret OR set the environment variables S3_ACCESS and S3_SECRET
   3) s3_key: also supply --s3_access, --s3_secret and --s3_bucket OR set the environment variables S3_ACCESS and S3_SECRET and supply --s3_bucket

 --cycle_id [cycle_id]                       # Retrieve data generated during specified cycle if dataset is associated with an app [default: last cycle]
 --s3_access [s3_access_key]                 # S3 access key
 --s3_secret [s3_secret_key]                 # S3 secret key
 --s3_bucket [s3_bucket]                     # S3 bucket to store data at
 --s3_key [s3_file_key]                      # S3 key to store data at
```

### data:show   

```bash
$ zillabyte help data:show 
Usage: zillabyte data:show ID

 Shows a sample of the dataset. See 'zillabyte queries' for
 more elaborate functionality.

 --cycle_id [cycle_id]                       # Retrieve data generated during specified cycle if dataset is associated with an app [default: last cycle]
 --no_truncation                             # Don't truncate long strings
 --meta                                      # Show metadata columns (since, confidence, source)
```

