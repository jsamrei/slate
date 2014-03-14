# How To: Analyzing the App Store

A recent Zillabyte user wanted to generate a marketing leads list targeting startups in the mobile space.  Specifically, this user wanted to identify all the publishers in the App Store and corresponding meta data about each app.  The user postulated that publishers in the App Store with recent spikes in traffic will be ideal leads for their product.

This flow was relatively easy to build in Zillabyte.  Here it is in its entirety: 

```ruby
require "zillabyte"

flow = Zillabyte.new()

flow.spout do |node|
  
  node.emits([["feed", ["url"]]])
  
  node.next_batch do |controller|
    @urls = [] # ... a seed list of app store URLs
    @urls.each do |url|
      controller.emit("feed", {"url" => url})
    end
  end

end


flow.each do |node|
  
  node.emits([
    ["app_store_rank", ["country", "feed_type", "subgenre", "id", "ranking"]]
  ])

  node.execute do |controller, tup|
    open(tup["url"]) do |xml|
      
      feed = RSS::Parser.parse(xml)
      feed.items.each_with_index do |item, index|
        
        # Get the app id...
        id = URI.parse(item.id.content).path[/\d+$/].to_i()

        # Grab the meta data... 
        if item["has_explicit_content"].nil?()
          controller.emit("app_store_rank", {
            "country" => item["country"],
            "feed_type" => item["feed_type"],
            "subgenre" => item["subgenre"],
            "id" => id,
            "ranking" => index + 1
          })
        end
      end
      
    end
  end
end


flow.sink do |node|
  node.consumes "app_store_rank"
  node.name "app_store_rank"
  node.column "country", :string
  node.column "feed_type", :string
  node.column "subgenre", :string
  node.column "id", :integer
  node.column "ranking", :integer
end
```

This is a fairly elaborate flow with three main components. Lets dissect and discuss piece by piece. 

### The Spout

A spout is responsible for sourcing all data in the flow.  In this case, the spout is responsible for identifying all the App Store URLs to crawl.  The following accomplishes this and emits all URLs to the next operation. 

```ruby
flow.spout do |node|
  
  node.emits([["feed", ["url"]]])
  
  node.next_batch do |controller|
    @urls = [] # ... a seed list of app store URLs
    @urls.each do |url|
      controller.emit("feed", {"url" => url})
    end
  end

end
```

By default, spouts are not parallelized across the flow.  In most cases, this is not an issue because spouts tend to work on small chunks of data, as is the case here. 

### Crawling the App Store Content

The next operation in the flow is the `each`.  This operation is responsible for actually downloading the App Store content.  Note that when this is performed in Zillabyte, we will automatically scale and distribute the code across the Zillabyte cluster.  This allows the following block of code to read the various RSS feeds in parallel. This significantly improves throughput. 

```ruby
flow.each do |node|
  
  node.emits([
    ["app_store_rank", ["country", "feed_type", "subgenre", "id", "ranking"]]
  ])

  node.execute do |controller, tup|
    open(tup["url"]) do |xml|
      
      feed = RSS::Parser.parse(xml)
      feed.items.each_with_index do |item, index|
        
        # Get the app id...
        id = URI.parse(item.id.content).path[/\d+$/].to_i()

        # Grab the meta data... 
        if item["has_explicit_content"].nil?()
          controller.emit("app_store_rank", {
            "country" => item["country"],
            "feed_type" => item["feed_type"],
            "subgenre" => item["subgenre"],
            "id" => id,
            "ranking" => index + 1
          })
        end
      end
      
    end
  end
end
```

### The Sink

The final step is to sink the data to Zillabyte's persistent storage.  Once the data is sunk, it can be downloaded by the user.  The only caveat at this stage is that data types and columns must be explicitly declared.  That is, we need to tell Zillabyte which fields are strings, integers, etc. 

```ruby
flow.sink do |node|
  node.name "app_store_rank"
  node.column "country", :string
  node.column "feed_type", :string
  node.column "subgenre", :string
  node.column "id", :integer
  node.column "ranking", :integer
end
```


### Conclusion 

The above flow is a quick example of how users can leverage Zillabyte to extract key insights from the world's information.  In this case, we used a flow to crawl the App Store and extract key metrics, which can then be imported into, say, Salesforce and used to score leads.  Even cooler, once this flow is up, it will continually run, and the user can be notified of changing events.  Kind of like a Google Alerts on steroids. 

