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

In a similar manner to component inputs, we declare the component output schema for the example. 

