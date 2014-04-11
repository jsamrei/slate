---
title: Apps
---

# Apps

Zillabyte data applications are an easy way of defining data tranformations. An application is executed simultaneously across several machines on our distributed cluster. Data is streamed through this.

### Parts of an app

To define the flow of data through the app, we need three main components that define the data we act on (`source`), what the computation on each row of the data (`each`) and finally where the results are stored(`sink`). An app uses combinations of these components.


#### Source 

```ruby
stream = app.source {
 emit :foo => "hi"
 emits 'stream_a', 'stream_b'
 next_batch {
   emit 'stream_a', :foo => 'hi'
   emit 'stream_b', :bar => 3
 }
}
```



#### Each

```ruby
stream.each do
  name "some_unique_name" #Optional
  emits "stream_1" # Optional if one stream, required if more than one.
  execute do |tuple|
    # Do something with tuple
    emit ...
  end
end
```

#### Sink

```ruby
.sink{
    name "has_hello_world"
    column "url", :string
  }
```

### Advanced Options

#### Multi-stream emits

```ruby
app = Zillabyte.app("multi_stream")
pages = app.source("select * from web_pages")
h, b = pages.each do 
  emits "hello_world", "goodbye_world" # Ordering is important
  execute do |page|
    emit "hello_world", page['url'] if page['html'].include? "hello world"
    emit "goodbye_world", page['url'] if page['html'].include? "bye world"
  end
end
h.sink do
  name "has_hello_world"
  column "url", :string
end
b.sink do 
  name "has_goodbye_world"
  column "url", :string
end
```

#### Single stream, multiple listeners

```ruby 
app = Zillabyte.app("multi_stream")
pages = app.source("select * from web_pages")
h = pages.each do |page|
  emit page['url'] if page['html'].include? "hello world"
end
g = pages.each do |page|
  emit page['url'] if page['html'].include? "bye world"
end
h.sink do
  name "has_hello_world"
  column "url", :string
end
b.sink do 
  name "has_goodbye_world"
  column "url", :string
end
```
