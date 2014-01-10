require 'spidr'

Spidr.site('http://www.naver.com/') do |spider|
  spider.every_url { |url| puts url }
end
