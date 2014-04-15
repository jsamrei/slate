# How To: Find Jobs on the Web

One of Zillabyte's core principles is its flexibility.  Many websites expose information using RDF (Research Description Framework), a core component of W3C's semantic web stack.  This example demonstrates how one might process job openings on Indeed using a combination of Zillabyte's native features and its support for third-party gems.

### Use case
This use case actually grew out of something we are interested in here at Zillabyte--namely, which companies are hiring full-time developers to perform large-scale data extraction and analysis tasks?  There are many aggregate job sites on the web, but this example just focuses on Indeed.

As mentioned above, Indeed uses RDF.  This is easy to determine by analyzing the source code of a search results page:

```html
<div class="row " id="p_c2c36f4266233baf" itemscope itemtype="http://schema.org/JobPosting">
```

The use of itemtype in particular is generally a strong clue that a site is using RDF.   Sites that use RDF encode semantic information alongside regular HTML tags describing relationships between entities on the page (or potentially across a larger scope).  As such, they are particularly well-suited to automated extraction and analysis.

RDF sports a formidable set of specifications (you may read them [[http://www.w3.org/RDF/ here]]).  Fortunately, many of its features have been implemented in third-party Ruby gems, including:

*   rdf-rdfa
*   sparql
*   and of course Ruby's own RDF module (part of its standard library).

This article is not intended as an introduction to RDF, but as an example of how powerful Zillabyte can be when combined with a set of rbobust third-party libraries.  Without further ado, here is a core snippet of the code we use to parse Indeed:

```ruby
require 'zillabyte'

# For URI parsing
require 'uri'
require 'open-uri'

# For XML parsing
require 'nokogiri'
require 'equivalent-xml'

# For RDF
require 'rdf/rdfa'
require 'sparql'

# We reuse two values several times over the course of this app: the base address of the RDF schema and
# the list of attributes that define our final schema.  So we define them here.
SCHEMA = RDF::Vocabulary.new "http://schema.org/"

SCHEMA_ATTRIBUTES = ["address_locality", "hiring_organization", "title", "description", "name"]

app = Zillabyte.new "zillabyte_indeed"

# We start by outputting the URLs from which we wish to extract information.
# This has been simplified considerably to only deal one page and one search term.
app.spout do |node|
  node.emits [["feed", ["url"]]]

  node.next_batch do |controller|
    controller.emit "feed", {
      "url" => "http://www.indeed.com/jobs/?q=web+crawling"
    }
  end
end

# Next, we process each URL by interpreting it as an RDF graph.
app.each do |node|
  node.name "each_job_posting"
  node.emits [["indeed_job_posting", SCHEMA_ATTRIBUTES]]

  node.execute do |controller, tup|
    # We wrap the entire app in a begin-rescue block, so that for unexpected exceptions we do not break our app
    # completely.  Note that one should *NOT* catch 'Exception', ever--this breaks signal handling and prevents
    # clean shutdown of a app.
    begin
      # Using the third party library, we first load the graph...
      url = tup["url"]
      rdf_graph = RDF::Graph.load url

      # Then construct a query for each predicate in the document...
      job_posting_query = RDF::Query.new job_posting: {
        RDF.type => SCHEMA.JobPosting,
        SCHEMA.hiringOrganization => :hiring_organization,
        SCHEMA.jobLocation => :job_location,
        SCHEMA.title => :title,
        SCHEMA.description => :description,
        SCHEMA.name => :name,
      }

      job_location_query = RDF::Query.new job_location: {
        RDF.type => SCHEMA.Place,
        SCHEMA.address => :address,
      }

      job_postal_address_query = RDF::Query.new :address => {
        RDF.type => SCHEMA.Postaladdress,
        SCHEMA.addressLocality => :address_locality,
      }

      # Here, we join the three queries using Ruby's SPARQL gem (SPARQL is a language that is based on relational
      # algebra, like SQL, but also features a number of important differences), and then execute the query to
      # arrive at a solution:
      solution_set = SPARQL::Algebra::Operator::Join.new(
        SPARQL::Algebra::Operator::Join.new(job_location_query, job_posting_query),
        job_postal_address_query
      ).execute rdf_graph

      # To close out the each node, we iterate over the solution set and emit a tuple for each record.
      solution_set.each do |solution|
        controller.emit "indeed_job_posting", solution.bindings.select { |attribute, *| SCHEMA_ATTRIBUTES.include? attribute.to_s }
      end
    rescue => e
      # Print to standard error--this is more semantically correct and will show up during execution of `zillabyte apps:test`.
      STDERR.puts "Error:\n" + e.message + "\n" + e.backtrace.join("\n")
    end
  end
end

# The last step, as always, is to sink our newly extracted information to the database for later analysis.
app.sink do |node|
  node.name "indeed_job_posting"

  node.column "address_locality", :string
  node.column "hiring_organization", :string
  node.column "title", :string
  node.column "description", :string
  node.column "name", :string
end
```

### Push it to our servers

```bash
$ zillabyte push
```

### Now your algorithm is being processed with our infrastructure!


With a few tweaks, you can use this code to extract semantic information from any page exposing information through RDF.