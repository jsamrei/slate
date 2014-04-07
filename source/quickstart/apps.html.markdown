---
title: Apps
---

# Apps

Zillabyte data applications are an easy way of defining data tranformations. An application is executed simultaneously across several machines on our distributed cluster. Data is streamed through this 

### Parts of an app

To define the flow of data through the app, we need three main components that define the data we act on (`source`), what the computation on each row of the data (`each`) and finally where the results are stored(`sink`). An app uses combinations of these components.

#### Source 

```ruby
stream.source do

end
```

#### Each

```ruby
stream.each do

end
```

#### Sink

```ruby
stream.sink do

end
```

### Simple App

A `simple_app` is a convenient wrapper around an `app` 
