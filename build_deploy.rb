#!/usr/bin/env ruby
require 'hipchat'

#### MAKES SURE LATEST CHANGES ARE ON GITHUB
if system("git diff --exit-code --quiet HEAD") == false
  puts "It looks like you have uncommitted changes... exiting"
  # exit(1)
end
puts "PUSHING CHANGES UP..."
sleep(3)
system("git push origin")



puts "Building Documentation using Middleman..."
build = system('bundle exec middleman build')

if build
  puts "Pushing Documentation to S3 => s3://docs.zillabyte.com"
  push_s3 = system("cd ./build && s3cmd put -P --recursive ./ s3://docs.zillabyte.com")
  push_s3 = true
else
  "[FAIL] Middleman build failed"
end

if push_s3
  git_branch = `git rev-parse --abbrev-ref HEAD`
  puts "Pushed to S3 successfully from #{git_branch.chomp}."
  hip_client = ::HipChat::Client.new "41005d1d7b1a5cdc86dc2d9db1b620"
  hip_client['Zillabyte'].send('docs', "Documentation was pushed from branch #{git_branch.chomp}.", :message_format => "text", :color=> 'green')        
else
  puts "[FAIL] Failed to push build to S3."
end
