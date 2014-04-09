# How To: Terms of Service Monitoring

A Zillabyte customer asked us to find all the Stripe-powered companies that sold porn or cigarettes, with an interesting twist at the end - take a screenshot of each site matching the query.  Here's how we did it.

### Identifying Stripe-powered companies

We researched Stripe in order to find out what signaled a Stripe-powered payment processor. 

We determined, by looking at Stripe documentation, that the following were signals: "js.stripe.com" and "checkout.stripe.com"

### Identifying porn and cigarette sites

For simplicity's sake, we search for the keywords porn or cigarette.  A more advanced search, which is possible through Zillabyte is to include a dicitionary of cigarette brands,  or to import a list of known porn sites, perhaps from a software company. 

### Getting screenshots

[CasperJS](casperjs.org) is a great scripting & testing utility, written in Javascript.  Although we do not yet support Javascript, it can still be used, as these libraries are installed on our servers.  In the following, we wrote an external casperJS file to take screenshots, given an argument of a URL.  Within the simple_app script we used bash calls to run it. 

### Downloading the screenshot files

In the following, for each screenshot, we saved it to the server, pushed it to an s3 bucket, and deleted it from the server.  Our servers have s3cmd installed, making this kind of action easy.



### The Code
```ruby
require 'zillabyte'

Zillabyte.simple_app do

  name "stripe_tos" # describe your app with a name
  
  matches "select * from web_pages" # use zillabyte web corpus as input 
  
  emits [ 
          [ 
            "stripe_tos", [ {"URL"=>:string} ]
          ]
        ]

  
  execute do |tuple|
    
    url = tuple['url']
    html = tuple['html']

    if html.include?('js.stripe.com') || html.include?('checkout.stripe.com')
      if html.include?('cigarette') || html.include?('porn')

        emit("stripe_tos", "URL" => url) # write url to the relation
            
        # in order to name our .png files
        domain_regex = /http:\/\/w{3}?(\w*)/
        truncate_url = url.scan(domain_regex)

        s3bucket = "stripe_tos"

        if `casperjs screenshot.js #{url}` # use external casperjs file to take screenshot
          STDERR.puts "screenshot taken" # I use STDERR to write to the logs.

          s3cmd = `s3cmd put match.png s3://customers.zillabyte.com/#{s3bucket}/#{Date.today.to_s}/#{truncate_url[0][0]}.png`
          STDERR.puts "file saved in s3"

          cleanup = `rm match.png`
          STDERR.puts "file deleted from cluster"
        
        else
          
          STDERR.puts "screenshot not taken"
        
        end


      end
    end
    
  end

end
```

### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!

Once we support Javascript, all of the above can be easily written in Javascript. 