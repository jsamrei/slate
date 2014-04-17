# How To: Determining Market Coverage of Shopify in San Francisco

A Zillabyte customer asked us to find all the Shopify-powered companies in San Francisco. Here's how we did it.

### Identifying Shopify-powered companies

We researched Shopify sites, in order to find out what signaled a shopify site. 

We determined, by looking at a few Shopify sites, that the following were likely signals. 

"myshopify.com", "Shopify.shop", "Shopify.theme"

### Identifying San Francisco companies

San Francisco has the following zipcodes:  94102, 94103, 94104, 94105, 94107, 94108, 94109, 94110, 94111, 94112, 94114, 94115, 94116, 94117, 94118, 94121, 94122, 94123, 94124, 94127, 94129, 94130, 94131, 94132, 94133, 94134, 94158.  Interestingly, they all begin with 941, a fact we can take advantage of. 


### The Code
```ruby
require 'zillabyte'

app = Zillabyte.app("shopify")  

input = app.source "select * from web_pages"

stream = input.each do |tuple|
  html = tuple['html']
  url = tuple['url']
  # look for pages that are built on shopify.  
  if html.scan('myshopify.com') or html.scan('shopify.shop') or html.scan('shopify.theme') 

    # all san francisco zip codes begin with 941xx.
    # make a regular expression to find 5 digit numbers
    # that have a whitespace before it
    # and end in either a comma or a whitespace
    regex_for_zip = Regexp.new('\s(941[\d]{2})[,\s]')

    ary = html.scan(regex_for_zip)
    
    unless ary.empty?
      
      zip = ary[0]
      # emit a new table called shopify_in_sf,
      # with two columns, the URL and the zipcode
      emit{"URL" => url, "zipcode" => zip}
    end

  end
    
end

stream.sink do 
  name "shopify_SF"
  column "url", :string
  column "zipcode", :integer
end
```
### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!

In the near future, we will be adding a geographic information system data relation, enabling you to easily plot this onto maps!
