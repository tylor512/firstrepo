require 'spidr'
require 'optparse'

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

# Start Script Spidr by URL()
puts "start at: #{start_url}"
Spidr.user_agent = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0; Touch)"
Spidr.start_at(start_url) do |spider|
  spider.every_page do |page|
  	puts "page: #{page.url}"
  	page.urls.each do |url|
  	  #puts "url: #{url.to_s}"
  	  url_patterns.each do |url_pattern|
  	    if url_pattern.match(url.to_s)
  	      puts url
  	      puts url_pattern
  	    end
  	  end
  	end
  end
end