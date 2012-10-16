$:.unshift File.expand_path('lib', File.dirname(__FILE__))
#$LOAD_PATH << File.join(Dir.getwd, 'lib')

require 'sinatra/assetpack'
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/contrib'
require 'sinatra/content_for'
require 'helpers/base'
require 'helpers/colors'

require 'api/v1'

require 'json'

module WkaMole
  class Extractor < Sinatra::Base
    helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

    register Sinatra::AssetPack
    register Sinatra::ConfigFile

    use Api::V1

    set :version, 'v1'

    configure(:production, :development) do
      enable :logging, :dump_errors, :raise_errors, :static
    end

    config_file 'config/config.yml'

    assets {
      js :inject, '/javascripts/inject.js', [ '/javascripts/includes/jquery.min.js', '/javascripts/includes/jquery.base.extend.js', '/javascripts/includes/jquery.curstyles.js' ]
      js :screenshot, '/javscripts/screenshot.js', ['/javascripts/includes/jquery.min.js', '/javascripts/includes/quantize.js', '/javascripts/includes/color-thief.js']
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

    get '/ping.json' do
      {:status => :ok}.to_json
    end

    get '/' do
      debugger
      erb :home
    end

    get 'all' do
      redirect '/'
    end

    post '/all' do
      erb :all
    end

    get '/colors' do
      @res = `#{settings.phantom_cmd} lib/phantom/version1/colors.js #{params[:site]} #{inject_assets}`
      @domaint_colors = @rest_colors = []
      colors = eval(@res)
      if colors
        @domaint_colors = [colors.group_by.sort_by{|ele| ele.length}.uniq.reverse.slice(0)]
        @rest_colors = colors.group_by.sort_by{|ele| ele.length}.uniq.reverse - @domaint_colors
      end
      erb :colors, :layout => false
    end

    get '/typography' do
      @res = `#{settings.phantom_cmd} lib/phantom/version1/typography.js #{params[:site]} #{inject_assets}`
      erb :typography, :layout => false
    end

    get '/screenshot' do
      @url = screenshot(params[:site])
      erb :screenshot, :layout => false
    end
  end
end
