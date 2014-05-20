How to use this repo: 



In order to add a page, you must do 3 things. 

1) add markdown file in the appropriate folder within the SOURCE folder

2) add your entry to /locales/en.yml

3) edit /basics/layouts/_nav.erb

To run locally: `bundle`, then `middleman`. Navigate to localhost:4567

If everything checks out, to push to s3 and deploy, run 

`ruby build_deploy.rb`
