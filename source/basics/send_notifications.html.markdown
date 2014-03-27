---
title: Send notifications
---
## Send notifications

Zillabyte allows you to run a flow on the web continously.  Given that it is constantly running, you may want to be notified or alerted when something new shows up. Here's how it works.

```ruby
  # This line of code will send you an email
  # when your dataset has changed. For example, 
  # if a new match is discovered, you will be notified.
  # Options include: your email, whether you want 
  # the notification pushed to your email, and which
  # dataset you want to be alerted about.
  
  send_email("YOURNAME@YOURDOMAIN.COM", push => true, 
    dataset => YOUR_DATASET)
```

You may not want to be notified in real-time, especially if there are many results. If the push value is set to false, you will not be alerted upon
each change to your dataset.  Instead, you can set a time interval. 

```ruby
  push => 60*60*24*7 # send an email every week (60s*60m*24hr*7day)
```

For example, using the Domains dataset, search through HTML.

```ruby
require 'zillabyte'

Zillabyte.simple_function do |fn| 

  fn.name "hello_world"
  fn.matches [["domains", ["url", "html"]]] 
  fn.emits [["hello_world", ["url"]]] 
  
  fn.execute do |tuple, collector| 
    
  url = tuple['url']
  html = tuple['html'] 
  
  if html.include?('hello world')
    controller.emit("hello_world", "URL" => url)
    
    # Send an email to yourname@yourdomain.com when 
    # the hello_world is updated.
    send_email("yourname@yourdomain.com", push => true, 
      relation => "hello_world")
    
  end 
  
end 
```

Try the above out by copying it to a Zillabyte directory!

[HTML5 Boilerplate]: http://html5boilerplate.com/
[SMACSS]: http://smacss.com/
