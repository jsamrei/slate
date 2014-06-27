
## Queries

Queries allow you to perform analysis on your relations. The Zillabyte SQL engine is compatible with the Postgres 9.4 syntax.

``` bash
  query:pull          #  executes a queries and downloads the results to FILE
  query:pull:s3       #  pulls query data to S3_BUCKET/FILE_KEY/part***.gz
  query:sql           #  executes queries against the zillabyte corpus
  query:sxp           #  executes queries against the zillabyte corpus

```

### query:pull

```bash
$ zillabyte query:pull
Usage: zillabyte query:pull QUERY FILE

 executes a queries and downloads the results to FILE

 pulls query data to OUTPUT.gz

``` 

### query:pull:s3

```bash
$ zillabyte query:pull:s3
Alias: query:pull:s3 redirects to query:pull_to_s3
Usage: zillabyte query:pull:s3 QUERY S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY

 pulls query data to S3_BUCKET/FILE_KEY/part***.gz
 --output_type OUTPUT_TYPE       # specify an output format type i.e. json

``` 

### query:sql

```bash
$ zillabyte query:sql
Usage: zillabyte query:sql EXPRESSION

 executes queries against the zillabyte corpus

 -o, --offset OFFSET  # skips to the offset (default: 0)
 -l, --limit LIMIT    # sets the result limit (default: 20)
 -t, --tail TAIL      # continuously watches for new results
 -s, --since SINCE    # newer records since
 --no_truncation      # doesn't truncate long strings
 --output_type OUTPUT_TYPE          # The result display type

Examples:

 $ zillabyte query:sql "select * from company" --limit 100

``` 

### query:sxp

```bash
$ zillabyte query:sxp
Usage: zillabyte query:sxp EXPRESSION

 executes queries against the zillabyte corpus

 -o, --offset OFFSET  # skips to the offset (default: 0)
 -l, --limit LIMIT    # sets the result limit (default: 20)
 --output_type OUTPUT_TYPE          # the output format type i.e json
 -t, --tail TAIL      # continuously watches for new results

Examples:

 $ zillabyte query:sxp "(uses company 'web_css')" --limit 100
``` 




