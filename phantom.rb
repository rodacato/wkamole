$:.unshift File.expand_path('lib', File.dirname(__FILE__))

require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/content_for'

module WkaMole
  class Extractor < Sinatra::Base
    helpers Sinatra::ContentFor
    
    configure(:production, :development) do
      enable :logging, :dump_errors, :raise_errors
    end

    set :phantom_cmd, 'phantomjs'
    
    configure :production do
      set :phantom_cmd, './vendor/phantomjs/bin/phantomjs'
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
      erb :home
    end

    post '/all' do
      @res = `#{settings.phantom_cmd} lib/typography.js #{params[:site]}`
      erb :all
    end

    get '/:site/colors' do
   	  res = `#{settings.phantom_cmd} lib/color.js http://www.#{params[:site]}`
  	  res
    end

    get '/:site/typography' do
      content_type 'text/css', :charset => 'utf-8'
      res = `#{settings.phantom_cmd} lib/typography.js http://www.#{params[:site]}`

      "// For: #{params[:site]} \n\n #{res}"
    end
  end
end
