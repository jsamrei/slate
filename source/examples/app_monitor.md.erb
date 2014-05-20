# How To: Analyzing the App Store

A recent Zillabyte user wanted to generate a marketing leads list targeting startups in the mobile space.  Specifically, this user wanted to identify all the publishers in the App Store and corresponding meta data about each app.  The user postulated that publishers in the App Store with recent spikes in traffic will be ideal leads for their product.

### The Code

```ruby
require "zillabyte"

app = Zillabyte.app("app_monitor")

source_stream = app.source do

  begin_cycle do
    @urls = [] #... a seed list of app store URLs
  end

  next_tuple do
    url = @urls.shift
    if url
      emit :url => url
    end
  end
end

each_stream = stream.each do |tuple|

  tuple[:url]
  open(tuple[:url]) do |xml|

    feed = RSS::Parser.parse(xml)
    feed.items.each_with_index do |item, index|

      id = URI.parse(item.id.content).path[/\d+$/].to_i()

      # Grab the meta data... 
      if item["has_explicit_content"].nil?()
        emit("app_store_rank", {
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

each_stream.sink do
  name "app_store_rank"
  column "country", :string
  column "feed_type", :string
  column "subgenre", :string
  column "id", :integer
  column "ranking", :integer
end

```

This is a fairly elaborate app with three main components. Lets dissect and discuss piece by piece. 

### The Source

A source is responsible for sourcing all data in the flow.  In this case, the source is responsible for identifying all the App Store URLs to crawl.  The following accomplishes this and emits all URLs to the next operation. 

```ruby
source_stream = app.source do
  begin_cycle do
    @urls = [] #... a seed list of app store URLs
  end

  next_tuple do
    url = @urls.shift
    if url
      emit :url => url
    end
  end
end
```

### Crawling the App Store Content

The next operation in the flow is the `each`. This operation is responsible for actually downloading the App Store content. Zillabyte will then automatically scale and distribute the code across its cluster. This allows the following block of code to read the various RSS feeds in parallel,significantly improving throughput.

```ruby
each_stream = stream.each do |tuple|
  tuple[:url]
  open(tuple[:url]) do |xml|
    feed = RSS::Parser.parse(xml)
    feed.items.each_with_index do |item, index|
      id = URI.parse(item.id.content).path[/\d+$/].to_i()

      # Grab the meta data... 
      if item["has_explicit_content"].nil?()
        emit("app_store_rank", {
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
```

### The Sink

The final step is to sink the data to Zillabyte's persistent storage. This is where an output relation's schema is declared. Once the data is sunk, it can be downloaded by the user. 

```ruby
each_stream.sink do
  name "app_store_rank"
  column "country", :string
  column "feed_type", :string
  column "subgenre", :string
  column "id", :integer
  column "ranking", :integer
end
```

### Conclusion 

The above flow is a quick example of how users can leverage Zillabyte to extract key insights from the world's information. In this case, we used a flow to crawl the App Store and extract key metrics, which can then be imported into, say, Salesforce and used to score leads. Even cooler, once this flow is up, it will continually run, and the user can be notified of changing events.

