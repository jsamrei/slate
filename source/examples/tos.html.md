# How To: Terms of Service Monitoring

A Zillabyte customer asked us to find all the companies that use their payment processor service but violate the terms of their service. For legal reasons, it is required that a screenshot of each site matching the query.  Here's how we did it.

### Identifying companies powered by a payment processor

Payment processers conveniently have a unique signal in the form of a javascript widget. In this example, the tag is: `"js.payment.processor.com"`.

### Identifying sites that violate TOS

For simplicity's sake, we search for specific keywords that would violate the TOS. In our example we'll use the list of words: `['illegal','contraband','nefarious']`.  A more advanced search, which is possible through Zillabyte is to include a dictionary of words, or an algorithm with a set of rules to define violators.

### Getting screenshots

[CasperJS](casperjs.org) is a great scripting & testing utility, written in Javascript.  This library was installed on our servers for this functionality.  We wrote an external casperJS file, called "screenshot.js" to take screenshots, given an argument of a URL.  Within the simple_app script we used bash calls to run it. 

### Downloading the screenshot files

In the following, for each screenshot, we saved it to the server, pushed it to an s3 bucket, and deleted it from the server.  Using an external gem like rightAWS makes this easy.



### The Code
```ruby
require 'zillabyte'
require 'right_aws'

app = Zillabyte.app "tos"

input = app.source "select * from web_pages"
  
stream = input.each do |tuple|
  if html.include?("js.payment.processor.com")
    if not html.scan($regex).empty?

      # in order to name our .png files
      domain_regex = /http:\/\/w{3}?(\w*)/
      truncate_url = url.scan(domain_regex)
      
      $s3bucket = "tos_monitoring"
      s3 = RightAws::S3.new(accesskey, secretkey)
      $bucket1 = RightAws::S3::Bucket.create(s3, $s3bucket, true)
      $regex = Regexp.union('illegal','contraband','nefarious')
      

      if `casperjs screenshot.js #{url}` # use external casperjs file to take screenshot
        log "screenshot taken"

        key = RightAws::S3::Key.create($bucket1, "#{Date.today.to_s}/#{truncate_url[0][0]}.png") 

        x = File.read("match.png")
        key.put(x)
        
        emit{"URL" => url, "png_location"=> "s3://#{$s3bucket}/#{Date.today.to_s}/#{truncate_url[0][0]}.png"} # write url to the site

        log "file saved in s3"

        cleanup = `rm match.png`

        log "file deleted from cluster"
      else
        log "screenshot not taken"

      end
    end
  end
end
  
stream.sink do 
  name "tos"
  column "url", :string
  column "png_location", :string
end
```

### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!

Once we support Javascript, all of the above can be easily written in Javascript. 
