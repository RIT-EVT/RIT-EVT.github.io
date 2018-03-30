# Rakefile

require 'jekyll'

task default: %w[build]

desc "Build the site"
task :build do
  config = Jekyll.configuration({
    build_num: ENV["TRAVIS_BUILD_NUMBER"],
  })
  site = Jekyll::Site.new(config)
  Jekyll::Commands::Build.build(site, config)
end