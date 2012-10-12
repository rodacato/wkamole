require 'rubygems'
require 'sinatra'

get '/colors' do
  `phantomjs lib/colors.js http://www.crowdvoice.org`
end

get '/typography' do
  `phantomjs lib/typography.js http://www.crowdvoice.org`
end
