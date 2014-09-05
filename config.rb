<<<<<<< 
require "builder"
require './lib/redcarpet_header_fix'

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'


set :layout, :article

activate :livereload

activate :i18n

activate :directory_indexes

set :markdown, :fenced_code_blocks => true, :smartypants => true, :disable_indented_code_blocks => true, :prettify => true, :tables => true, :with_toc_data => true, :no_intra_emphasis => true
set :markdown_engine, :redcarpet


activate :fjords do |config|
  config.username = Bundler.settings["fjords_username"]
  config.password = Bundler.settings["fjords_password"]
  config.domain = "middlemanapp.com"
  config.gzip_assets = true
  config.cdn = true
end

configure :development do
  activate :relative_assets
end

configure :build do
  activate :minify_css
  activate :minify_javascript
end

class CodeLinker < Middleman::Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    helpers do 
      def link_file(path)
          out = File.open(path) { |f| f.read}  
      end
    end
end
::Middleman::Extensions.register(:code_linker, CodeLinker)

activate :code_linker
activate :google_analytics do |ga|
  ga.tracking_id = 'UA-51025679-3'
end



=======

# Activate the syntax highlighter
activate :syntax

# This is needed for Github pages, since they're hosted on a subdomain
activate :relative_assets
set :relative_links, true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

>>>>>>> bd6865585cc56d444a31905d0baeb1c7cea03f30
