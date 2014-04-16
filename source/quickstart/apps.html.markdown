---
title: Apps
---

# Apps

## Create a Zillabyte application

```ruby
require 'zillabyte'

app = Zillabyte.new "my_app"
```

The name of your application (`"my_app"`) identifies your application across our infrastructure. 


Zillabyte supports two syntax variants for building apps using data streams: (1) A simple syntax which should be sufficient for most common use cases and (2) an expanded syntax for advanced functionality. The following goes through the first then the second. 

## Parts of an app: `Source`, `Each`, and `Sink`

Each application has three primary components: `source`, `each`, and `sink` (described in more detail below). These are connected via a stream, which is the flow of data between these components. A component may emit one or more streams. 

## Source 

A `source` is the origin of the data flow, defined on the app object. The easiest way to stream data into a Zillabyte app is to use a Zillabyte relation. The `source` method takes in a single SQL string, producing a stream object.

```ruby
result_stream = app.source "select url,html from 
  web_pages"
```

In this case, the `source` pulls rows from the relation `web_pages`, with the columns `url` and `html`. The resulting stream object can then be used to define the next component.

## Each

The `each` block can be thought of as a Ruby map operation that runs across multiple machines. Rows of the stream are distributed across the systems and processed. The result of the `each` is another stream object that will contain the emitted rows. The input argument `tuple` contains a single row, stored as a Ruby hash.

```ruby
stream = result_stream.each do |tuple|
  emit :url => tuple['url'] if tuple['html'].include? 
  "hello_world"
end
```

This is syntactically equivalent to the following code snippet. The hello world example uses the brace `{}` syntax to chain components together, without having to name variables for each generated stream object. 

```ruby
stream = result_stream.each{ |tuple|
  if tuple['html'].include? "hello_world"
    emit :url => tuple['url'] 
  end
}
```

## Sink

The `sink` is a passive component that defines the schema of the rows that need to be saved. Of all the components where a stream is consumed, only the `sink` requires a schema to be defined. 

```ruby
.sink do
    name "has_hello_world"
    column "url", :string
end
```

The sink does not have an expanded syntax.

## Expanded Syntax

This section is for advanced use cases that are not satisfied by the syntax described above. The primary difference is the ability for a component to generate multiple streams of data. This is useful when each stream has a different set of fields. This is currently applicable only to the `source` and `each` components. A component supplies a list of stream names to the `emits` method to define multiple streams. 

```ruby
emits "stream_1", "stream_2"
```

For components that use the `emits` method, there is now an additional requirement. Each emitted row must explictly name one of the streams to emit to: 

```ruby
   emit 'stream_1', :foo => 'hi'
   emit 'stream_2', {:bar => 'baz', :foo => 'hi'}
```   

### Source

A `source` can also use data outside of Zillabyte relations. Any external data available on the web can be streamed into a Zillabyte app. To do so, we use the expanded syntax of a `source`. 

Note: We expect that the next_tuple call only emits a few rows at a time, although this is not enforced. For tasks that would take longer than a second, consider using `each` to perform the same task.

#### Single Stream

```ruby
stream = app.source do
  name "single_stream_source" #Optional
  begin_cycle do
    # Initialize the data and any local variables here
    @count = 0
    @rows = fetch_rows_from_external_source 
    # eg: csv/xml/rss
  end
  next_tuple do
    #Emit the next tuple 
    row = @rows.shift
    if row
      emit :foo => row
    end
  end
end
```

#### Multiple Streams 

Here is an example of using the `emits` clause within a `source`. 

```ruby
stream = app.source do
  name "multiple_stream_source" #Optional
  emits 'stream_a', 'stream_b'
  next_tuple do
    emit 'stream_a', :foo => 'hi'
    emit 'stream_b', :bar => 3
  end
end
```

### Each

#### Single Stream

This is semantically equal to the simple syntax block above, shown here for completeness. 

```ruby
stream.each do
  name "component_name" #Optional
  execute do |tuple|
    # Do something with tuple
    emit {:column => "value"}
  end
end
```

#### Multiple Streams

A common use case is to generate multiple streams from a single computation. For example, while parsing the html of a page, we may want one `stream` to emit the url only if "hello world" exists in the text, and another `stream` to emit all links found on the page.

```ruby
has_hello_world_stream, links_stream = stream.each do
  name "component_name" #Optional
  emits "has_hello_world", "links"
  execute do |tuple|
    # Do something with tuple
    emit "has_hello_world", {:url => tuple['url']} if tuple['html'].include? "hello world"
    links = parse_links(tuple['html']) # Function that parses links
    links.each do |link|
      emit "links", {:link => link}
    end
    
  end
end
```


## Wrapping it up: 

### Hello, Goodbye, World: Take One

This example shows the hello world example with a twist. This also executes an extra string search looking for a `'goodbye world'` and storing it in a separate sink. In this code block, the `each` component emits multiple streams using the expanded syntax.

![Zillabyte Multiple stream apps: Take 1](/images/Apps-Example1.png)


```ruby
app = Zillabyte.app("multi_stream")
pages = app.source("select * from web_pages")
hello_stream, goodbye_stream = pages.each do 
  name "all_worlds"
  emits "hello_world", "goodbye_world" # Ordering is important
  execute do |page|
    if page['html'].include? "hello world"
      emit "hello_world", :url => page['url'] 
    end
    if page['html'].include? "goodbye world"
      emit "goodbye_world", :url => page['url'] 
    end 
  end
end
hello_stream.sink do
  name "has_hello_world"
  column "url", :string
end
goodbye_stream.sink do 
  name "has_goodbye_world"
  column "url", :string
end
```


### Hello, Goodbye, World: Take Two

This code uses two separate `each` components to perform the seperate string searches that are respectively `sink`ed to a relation. Notice here that both `each` components are defined on the same `pages` stream object that was generated by the `source` component. Since the `each`s now only emit one stream, they can use the simpler `each` syntax for terseness.

![Zillabyte Multiple stream apps: Take One](/images/Apps-Example2.png)


To show alternative styles, here's the code with the brace `{}` syntax. Notice here that we don't save the stream object of the each to a local variable, but instead attach a `sink` directly to it.

```ruby 
app = Zillabyte.app("multi_stream")
pages = app.source("select * from web_pages")

pages.each{ |page|
  emit {:url => page['url']} if page['html'].include? "hello world"
}
.sink{
  name "has_hello_world"
  column "url", :string
}

pages.each { |page|
  emit {:url => page['url']} if page['html'].include? "bye world"
}
.sink{ 
  name "has_goodbye_world"
  column "url", :string
}
```

For completeness, the same code in the format as Take 1. 

```ruby 
app = Zillabyte.app("multi_stream")
pages = app.source("select * from web_pages")

hello_stream = pages.each do |page|
  emit {:url => page['url']} if page['html'].include? "hello world"
end

goodbye_stream = pages.each do |page|
  emit  {:url => page['url']} if page['html'].include? "goodbye world"
end

hello_stream.sink do
  name "has_hello_world"
  column "url", :string
end

goodbye_stream.sink do 
  name "has_goodbye_world"
  column "url", :string
end
```
