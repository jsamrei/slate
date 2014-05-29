#!/usr/bin/env ruby

#### MAKES SURE LATEST CHANGES ARE ON GITHUB
if system("git diff --quiet --exit-code HEAD") != 0
  puts "It looks like you have uncommitted changes... exiting"
  exit(1)
end
puts "PUSHING CHANGES UP..."
sleep(3)
system("git push origin")



puts "Building Documentation using Middleman..."
build = system('bundle exec middleman build')

if build
	puts "Pushing Documentation to S3 => s3://docs.zillabyte.com"
	push_s3 = system("cd ./build && s3cmd put -P --recursive ./ s3://docs.zillabyte.com")
else
	"[FAIL] Middleman build failed"
end

if push_s3
		puts "Pushed to S3 successfully."
else
	puts "[FAIL] Failed to push build to S3."
end
