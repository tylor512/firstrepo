require 'spidr'

start_url = ""
temp_url = ""

ARGV.each do|a|
  start_url = a
end

puts "start at: #{start_url}"
Spidr.user_agent = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0; Touch)"
Spidr.start_at(start_url) do |spider|
  spider.every_page do |page|
  	puts "page: #{page.url}"
  	page.urls.each do |url|
  		#puts "url: #{url.to_s}"
  		puts url.to_s.scan(/(.*)file\.js(.*)/)
  		puts url.to_s.scan(/(.*)mh1004\.com(.*)/)
  	end
  end
end