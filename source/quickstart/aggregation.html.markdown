---
title: Aggregation
---

# Aggregation

## How does aggregation work in Zillabyte?


With Zillabyte, applications can dynamically aggregate your data from many sources. These aggregation's can be tailored to specific needs. Using 
the provided Zillabyte functions and your programming wit, a wide variety
of aggregations can be performed.


## Group By

The Group By function can be used to implement various features which involve associative computation. Counts, sums, and other desired functions are creating using the following guidelines. Here is a full example of a word count operation in Zillabyte.




```ruby

count_stream = stream.group_by(:word) do
  begin_group do |g_tuple|
    @word = g_tuple[:word]
    @count = 0
  end

  aggregate do |tuple|
    @count += 1
  end

  end_group do |g_tuple|
    emit :word => @word, :count => @count
  end
end

```

### Declaration

Group by operations are declared in the same manner as other operations.

``` ruby
  count_stream = stream.group_by(:word) do
```

In this example, we are grouping tuples from the incoming stream by their `:word` value.


### Beginning the Grouping

The begin_group function allows you to specify the variables you would like to use during the aggregation. This is where you can set up associative metrics such as counters or maxima.

``` ruby
  begin_group do |g_tuple|
    @word = g_tuple[:word]
    @count = 0
  end
```

### Aggregating data

The `aggregate` function is run on each incoming tuple to modify the state declared in the `begin_group` function. In this case, we increment the counter associated with the grouped word.

``` ruby
  aggregate do |tuple|
    @count += 1
  end
```

### Ending the Grouping

The `end_group` function is utilized to emit the final aggregated data for other operations to utilize in your Zillabyte application. In this case 
we emit the words along with their counts.

``` ruby
  end_group do |g_tuple|
    emit :word => @word, :count => @count
  end
```



## Join












