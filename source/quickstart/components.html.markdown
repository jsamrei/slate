---
title: Components
---

# Components

## What are Components?

Components are reusable operations that allow a Zillabyte user to both streamline their application development process and the ability to call Zillabyte functions via a Remote Procedure Call(RPC). You can create your components or utilize public components created by Zillabyte or other members of the Zillabyte community to quickly add functionality to your workflow.

## Creating a component

Creating a component is done in a similar manner to creating an application. From your desired directory, name your component (in this case the simple "prefix_filter"), and initialize a template component.

```bash
    $ zillabyte components:init prefix_filter --lang ruby
```

To view a help topic on this function or any others, use the `"zillabyte help"` command:

```
   $ zillabyte help components:init
```


## A basic Zillabyte component

```ruby
require 'zillabyte'

comp = Zillabyte.component "prefix_filter"
```

The name of your component (`"prefix_filter"`) identifies your component across our infrastructure. 


```ruby
# Declare the schema for inputs to the component
url_stream = comp.inputs do
  name "urls"
  field "url", :string
end
```

Components work by declaring a "schema" of their inputs and outputs. The inputs are the expected fields they will look for within incoming tuples.
In this case, our component declares an input of "urls", and will look for the "url" field of any incoming tuples. 


```ruby
# This component strips HTTP and HTTPS prefixes
suffix_streams = url_stream.each do |tuple|
    emit :urls => tuple["url"].gsub(/^http(s)?:\/\//,"")
end
```
The incoming tuple stream can now be manipulated in the same manner as in full-fledged Zillabyte applications. In this case, we are running the code within the "each" for every incoming tuple. Our "each" strips the HTTP or HTTPS prefix off of the input "url". 


```ruby
# Declare the output schema for the component
suffix_streams.outputs do
  name "suffix_urls"
  field "urls", :string
end
```

In a similar manner to component inputs, we declare the component output schema for the example. This determines the output of the component for other Zillabyte functions to expect.

## Testing your component

  The `zillabyte test` command can be run within your component directory to allow you to interactively test your component. 

## Running your component

  To run your component, simply push it to Zillabyte. The component is able to accept RPC calls with individual queries or be integrated within other components or applications. Refer to the git/flow management tutorial and CLI reference for instruction as to how to push and manage your component.


## Viewing your component

  To view your components:

  ``` bash
    $ zillabyte components
  ```
  
  This command yields:

  ``` bash

  +----------+-------------+----------+----------+--------------+
  |   id     |   name      |  state   |   inputs |  outputs     |
  +----------+-------------+----------+----------+--------------+
  |   13     |prefix_filter|  RUNNING |   urls   | suffix_urls  |
  +----------+-------------+----------+----------+--------------+

  ```

## Component Remote Procedure Calls

  Once you have pushed your component to Zillabyte, you can make on demand queries to your component:

  ``` bash
    $ zillabyte rpc 'prefix_filter' "http://www.zillabyte.com"
  ```

  OR

  ``` bash
    $ zillabyte execute 'prefix_filter' "http://www.zillabyte.com"
  ```
  
  This command will wait for the query to finish and display the result. Alternatively, you may request the command to return a run_id for the query which can be used to obtain the status or result of the query through other rpc commands. Please see the CLI reference for more details.


## Nested Components

Components can be embedded into other components or even applications. When running RPC calls to an application that has an embedded component, that component is joined into the same execution environment as its parent, allowing for high throughput component execution.

