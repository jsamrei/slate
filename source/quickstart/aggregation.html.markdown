---
title: Aggregation
---

# Aggregation

## How does aggregation work in Zillabyte?


With Zillabyte, applications can dynamically aggregate your data from many sources. These aggregation's can be tailored to specific needs. Using 
the provided Zillabyte functions and your programming wit, a wide variety
of aggregations can be performed.


## Group By

### What is a Group By?

The Group By function can be used to implement various features which involve associative computation. Counts, sums, and other desired functions are creating using the following guidelines. Here is a full example of a word count operation in Zillabyte.

```ruby

count_stream = stream.group_by(:word) do

  # Initialize any counters and data that you would like to use for the aggregation
  begin_group do |g_tuple|
    @word = g_tuple[:word]
    @count = 0
  end

  # Perform aggregation on a tuple by tuple basis
  aggregate do |tuple|
    @count += 1
  end

  # Emit the finalized aggregate data
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

### What is a Join?

Join's allow you to combine two streams into one in a manner similar to traditional relational systems. Realtime tuple data can be joined to construct
views combining a variety of sources. Here is an example of a join in Zillabyte.


``` ruby
# This stream contains employees and their departments
people_stream = app.each do |tuple|  
  emit :person => tuple[:person], :dept => tuple[:person_dept]
end  
          
# This stream contains departments and their budgets
budget_stream = app.each do  
  emit :dept => tuple[:budget_dept], :budget => tuple[:budget] 
end  
          
# Here we join employees and their budgets based on a shared department field
combined_stream = people_stream.join_with(budget_stream, :on => :dept, :type => :inner)  


# The new stream contains the superset of the two streams
combined_stream.sink do
  name people_dept_budget
  column :person, :string
  column :dept, :string
  column :budget, :integer
end

```

### Declaring the join

Joins are declared in the following format :

``` ruby
output_stream = left_hand_stream.join_with(right_hand_stream, 
  :on => join_fields,
  :type => join_type
  )
```

The `left_hand_stream` and `right_hand_stream` variables correspond to the streams that you are joining.

### Specifying fields to join upon

Fields can be specified in the following formats:

```ruby
  :on =>  "shared_field"
```

This format specifies a single field that is shared between the two streams that is joined upon.
 
 Or:

  ```ruby
   :on => ["left_hand_field", "right_hand_field"]
  ```

This format allows joins on fields which differ in key name, but share overlapping values.


### Declaring the Join Type

The following join types are available

* :innner       - An inner join
* :outer        - An full outer join
* :left         - A left hand join
* :right        - A right hand join

Specifying the join type (the default is left) allows for the data sets to handle the cases of nulls or mismatches. The functionality of these types adhere to the conventions of standard relational joins.

















