
## Queries

Queries allow you to perform analysis on your relations. The Zillabyte SQL engine is compatible with the Postgres 9.4 syntax.

``` bash
$ zillabyte help query
  query:pull QUERY FILE                                       #  Executes a query and downloads the results to FILE.
  query:pull:s3 QUERY S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY  #  Executes a query and pulls data to S3_BUCKET/FILE_KEY/part***.gz.
  query:sql EXPRESSION                                        #  Executes SQL queries against the zillabyte corpus.
  query:sxp EXPRESSION                                        #  Executes SXP queries against the zillabyte corpus.
```

### query:pull

```bash
$ zillabyte help query:pull
Usage: zillabyte query:pull QUERY FILE

 Executes a query and downloads the results to FILE.
``` 

### query:pull:s3

```bash
$ zillabyte help query:pull:s3
Alias: query:pull:s3 redirects to query:pull_to_s3
Usage: zillabyte query:pull:s3 QUERY S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY

 Executes a query and pulls data to S3_BUCKET/FILE_KEY/part***.gz.
``` 

### query:sql

```bash
$ zillabyte help query:sql
Usage: zillabyte query:pull QUERY FILE

 Executes a query and downloads the results to FILE.
pig:cli_reference xiaoyingxu$ zl help query:pull:s3
Alias: query:pull:s3 redirects to query:pull_to_s3
Usage: zillabyte query:pull:s3 QUERY S3_KEY S3_SECRET S3_BUCKET s3_FILE_KEY

 Executes a query and pulls data to S3_BUCKET/FILE_KEY/part***.gz.
pig:cli_reference xiaoyingxu$ zl help query:sql
Usage: zillabyte query:sql EXPRESSION

 Executes SQL queries against the zillabyte corpus.

 -o, --offset OFFSET                         # Skips to the offset [default: 0]
 -l, --limit LIMIT                           # Sets the result limit [default: 20]
 -t, --tail TAIL                             # Continuously watches for new results
 -s, --since SINCE                           # Grab newer records since SINCE
 --no_truncation                             # Doesn't truncate long strings
 --meta                                      # Show meta columns (since, confidence, source)

Examples:

 $ zillabyte query:sql "select * from company" --limit 100
``` 

### query:sxp

```bash
$ zillabyte help query:sxp
Usage: zillabyte query:sxp EXPRESSION

 Executes SXP queries against the zillabyte corpus.

 -o, --offset OFFSET                         # Skips to the offset [default: 0]
 -l, --limit LIMIT                           # Sets the result limit [default: 20]
 -t, --tail TAIL                             # Continuously watches for new results
 --meta                                      # Show meta columns (since, confidence, source)

Examples:

 $ zillabyte query:sxp "(uses company 'web_css')" --limit 100
``` 

