


topics = `zillabyte help | grep -i '#' | xargs -L 1 echo`.split("\n").map {|t| t.split("#")[0].strip }

# Filter the topics you wish to generate here
# topics = ["apps", ....]


topics.each do |topic|
   
   top_help = `zillabyte help #{topic} | grep -i '#' | xargs -L 1 echo `
   puts topic

end



