require 'spidr'
require 'optparse'
require 'stargate'
require 'digest/sha1'

start_url = ""

# Get Parameters
ARGV.each do|a|
  start_url = a
end

# Load Script URL Patterns from File
url_patterns = []
File.open('url_patterns.txt').each do |line|
  url_patterns.push Regexp.new line.strip
end
p url_patterns

exit_requested = false
Kernel.trap( "INT" ) { exit_requested = true }

# this url is the default for stargate.
client = Stargate::Client.new("http://localhost:8080")

# Start Script Spidr by URL()
puts "start at: #{start_url}"
Spidr.user_agent = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0; Touch)"
Spidr.start_at(start_url) do |spider|
  spider.every_page do |page|
    if exit_requested
      spider.pause!
    end

    puts "page: #{page.url}"
    page.urls.each do |url|

      #puts "url: #{url.to_s}"
      url_patterns.each do |url_pattern|
        if url_pattern.match(url.to_s)
          # create the row 'sishen' with the data in the table 'users'
          # row = client.create_row('test_urls', Digest::SHA1.hexdigest(url.to_s), Time.now.to_i, {:name => 'cf:url', :value => url.to_s})
          row = client.create_row('test_urls', url.to_s, Time.now.to_i, {:name => 'cf:page', :value => page.to_s})
          puts url
          puts page.to_s
        end
      end
    end
  end
end
