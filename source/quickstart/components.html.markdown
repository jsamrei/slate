---
title: Components
---

# Components

## What are Components?

Components are reusable operations that allow a Zillabyte user to both streamline their application development process and the ability to call Zillabyte functions via a Remote Procedure Call(RPC). You can create your components or utilize public components created by the Zillabyte or other members of the Zillabyte community to quickly add functionality to your workflow.

## Creating a component

Creating a component is done in a similar manner to creating an application. From your desired directory, name your component(in this case the simple "prefix_filter"), and initialize a template component.

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

comp = Zillabyte.app "prefix_filter"
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
The incoming tuple stream can now be manipulated in the same manner as in full fledged Zillabyte applications. In this case, we are running and "eaches" for every incoming tuple that strips the HTTP or HTTPS prefix off of its "url". 


```ruby
# Declare the output schema for the component
suffix_streams.outputs do
  name "suffix_urls"
  field "urls", :string
end
```

In a similar manner to component inputs, we declare the component output schema for the example. This determines the output of the component for other Zillabyte functions to expect.

## Testing your component

  The `zillabyte test` command can be run within your component directory to allow you to interactively test your component. Refer to the TESTING_LINK page for more a detailed overview of local testing.

## Running your component

  To run your component, simply push it to Zillabyte. The command is able to accept RPC calls with individual queries or be intgegrated within other components or applications. Refer to the git/flow management tutorial and CLI reference for instruction as to how to push and manage your component.

## Component Remote Procedure Calls

  Once you have pushed your component to Zillabyte, you can make on demand queries to your component:

  ``` bash
    $ zillabyte components:rpc [ID] [QUERY_1_INPUTS] [QUERY_2_INPUTS] ...
  ```

  This component accepts the ID of the component in order to specify which component should be queried. To determine your component ID, use the 'zillabyte components' command to see your component status and view its ID.

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

  In this case, our 'prefix_filter' component has been assigned the ID 13. Now to query the component, run:


  ``` bash
    $ zillabyte components:rpc 13 ["http://www.zillabyte.com"] 
  ```
  

  This command will yield an execution ID of the ongoing request to the component. For this example the returned run_id is 27


  For complex components, the results may not be immediate, and thus the status of the component RPC call can be queried:

  ``` bash
    $ zillabyte components:results [27]
  ``` 

  Once the tuple has been fully processed by the component, the results will be displayed upon this call.



## Nested Components

Components can be embedded into other components or even applications. When running RPC calls to an application that has an embedded component, that component is joined into the same execution environment as its parent, allowing for high throughput component execution.

To see an advanced example of embedding components within applications, refer to the CRAWLER SCREENSHOT LINK example.

