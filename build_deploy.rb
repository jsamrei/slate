#!/user/bin/env ruby
puts "Building Documentation using Middleman..."
build = system('middleman build')

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