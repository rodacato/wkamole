$:.unshift File.expand_path('lib', File.dirname(__FILE__))

require 'sinatra/base'
require 'sinatra/contrib'

module WkaMole
  class Extractor < Sinatra::Base

    configure(:production, :development) do
      enable :logging
      enable :dump_errors
      set :raise_errors, true
    end

    error do
      e = request.env['sinatra.error']
      puts e.to_s
      puts e.backtrace.join("\n")
      "Application Error!"
    end

    before do
      logger.info params
    end

    get '/' do
      "Waka waka, waa wa waaa!"
    end

    get '/:site/colors' do
   	  res = `phantomjs lib/color.js http://www.#{params[:site]}`
  	  res
    end

    get '/:site/typography' do
      content_type 'text/css', :charset => 'utf-8'
      res = `phantomjs lib/typography.js http://www.#{params[:site]}`

      "// For: #{params[:site]} \n\n #{res}"
    end
  end
end
