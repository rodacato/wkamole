$:.unshift File.expand_path('lib', File.dirname(__FILE__))
#$LOAD_PATH << File.join(Dir.getwd, 'lib')

require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/content_for'
require 'sinatra/assetpack'
require 'helpers/base'
require 'helpers/colors'
require 'json'

module WkaMole
  class Extractor < Sinatra::Base
    helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

    register Sinatra::AssetPack

    configure(:production, :development) do
      enable :logging, :dump_errors, :raise_errors, :static
    end

    set :phantom_cmd, 'phantomjs'

    configure :production do
      set :phantom_cmd, './vendor/phantomjs/bin/phantomjs'
    end

    assets {
      js :inject, '/javascripts/inject.js', [ '/javascripts/includes/jquery.min.js', '/javascripts/includes/jquery.base.extend.js', '/javascripts/includes/jquery.curstyles.js' ]
    }

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

    get 'all' do
      redirect '/'
    end

    post '/all' do
      # Getting typography styles
      @typos = `#{settings.phantom_cmd} lib/typography.js #{params[:site]} #{inject_assets}`

      # Getting site screenshot
      # @screenshot = screenshot(params[:site])

      # Getting text colors
      # @colors = eval(`phantomjs lib/colors.js #{params[:site]} #{inject_assets}`)

      erb :all
    end

    get '/colors' do
      @res = `#{settings.phantom_cmd} lib/colors.js #{params[:site]} #{inject_assets}`
      @domaint_colors = @rest_colors = []
      colors = eval(@res)
      if colors
        @domaint_colors = [colors.group_by.sort_by{|ele| ele.length}.uniq.reverse.slice(0)]
        @rest_colors = colors.group_by.sort_by{|ele| ele.length}.uniq.reverse - @domaint_colors
      end
      erb :colors, :layout => false
    end

    get '/typography' do
      @res = `#{settings.phantom_cmd} lib/typography.js #{params[:site]} #{inject_assets}`
      erb :typography, :layout => false
    end

    get '/screenshot' do
      @url = screenshot(params[:site])
      erb :screenshot, :layout => false
    end
  end
end
