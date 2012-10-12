require 'rubygems'
require 'sinatra'

get '/colors' do
  x = `phantomjs lib/colors.js http://theindustry.cc`
  x
end

get '/typography' do
  x = `phantomjs lib/typography.js http://www.crowdvoice.org`

  arr = eval(x)

  arr.first
end
