# Rakefile written by Simon Oulevay on his blog post:
# http://alphahydrae.com/2012/08/testing-with-capybara-selenium-and-rspec/

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

desc "Run specs"

task :travis do
  ["rspec"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

task :default => :spec