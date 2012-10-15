$:.unshift File.expand_path('lib', File.dirname(__FILE__))
#$LOAD_PATH << File.join(Dir.getwd, 'lib')

require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/content_for'
require 'helpers/base'
require 'helpers/colors'
require 'json'

module WkaMole
  class Extractor < Sinatra::Base
    helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

    configure(:production, :development) do
      enable :logging, :dump_errors, :raise_errors, :static
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
      # Getting typography styles
      @typos = `#{settings.phantom_cmd} lib/typography.js #{params[:site]} #{base_url}`

      # Getting site screenshot
      @screenshot = screenshot(params[:site])

      erb :all
    end

    get '/:site/typography' do
      res = `#{settings.phantom_cmd} lib/typography.js http://www.#{params[:site]} #{base_url}`
      res
    end

    get '/:site/colors' do
      res = `#{settings.phantom_cmd} lib/color.js http://www.#{params[:site]}`
      res
    end

    get '/:site/screenshot' do
      screenshot(params[:site])
    end
  end
end
