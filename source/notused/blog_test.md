# Crawl an Entire Domain in One Line

Setting up a web crawler can be a substantial project... Especially if you would like to crawl anything more than a few hundred pages.  You need to spin up a cluster, build your algorithm so it can work in a distributed fashion, and then handle all of the weird bugs that happen in large-scale crawling.  It can takes weeks for a senior engineer to setup, and much longer for those unfamiliar with the area.   

...or, you can use Zillabyte: 

```bash
$ zillabyte execute "domain_crawl" "example.com"
```

```bash
# output
asdfasdf sdf asdf
asdfasdfa dfasdfa sdf
asdfasdfa asdf asdf
```

## What's Going On? 

Zillabyte offers a feature known as 'components'.  [Components](http://docs.zillabyte.com/faq#what_is_a_component) are reusable chunks of scalable code that can be invoked by other people.  Think of them as distributed User Defined Functions (UDFs).  Because it's hosted in the cloud, we don't need to worry about spinning up and provisioning servers.  Nor do you need to worry about the intricacies of building a distributed crawler-- it's all taken care of.  You can invoke the component from [Zillabyte's Command Line Interface](http://docs.zillabyte.com/faq#what_is_the_command_line_interface_cli).  

## How Much Does this Cost? 

Zillabyte charges by machine hours.  You only pay for what you use.  Zillabyte's pricing can be [found here](http://zillabyte.com/pricing).  In my trials of crawling a few domains, I only racked up a few fractions of a machine hour, so cost hasn't been an issue.  As an added bonus, you get $50 in platform credits when you register.

## I Need More Control

The `domain_crawl` component is 100% open source.  You are free to clone it and tweak it however you wish. 

[<img style="width:200px; height:45px" src="http://docs.zillabyte.com/images/fork_on_github.png">](http://www.github.com/zillabyte/domain_crawl)

You will, however, need to name it something other than `domain_crawl`.  For example, suppose you want to find all the outbound links of a domain.  Let's call it `domain_outbound_links`.  Tweak the code accordingly and then run the following command: 

```bash
$ zillabyte execute "domain_outbound_links" "example.com"
```

Tweaking the actual code is fairly simple once you understand the stream-programming paradigm.  For your convenience, you can see the above `domain_outbound_links` in the corresponding [branch on github](#TODO) (or view the [diff here](#TODO)).  If you're new to stream-programming, then check out this article: [TODO:PPP](TODO)




