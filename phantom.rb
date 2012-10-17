$:.unshift File.expand_path('lib', File.dirname(__FILE__))
#$LOAD_PATH << File.join(Dir.getwd, 'lib')

require 'app_base'
require 'sinatra/assetpack'

require 'api/v1'
require 'json'

module WkaMole
  class Extractor < AppBase
    register Sinatra::AssetPack
    
    use Api::V1
    
    set :version, 'v1'
    set :root, File.dirname(__FILE__)
    set :views, Proc.new { File.join(settings.root, "views") }
    
    assets {
      js :inject, '/javascripts/inject.js', [ '/javascripts/includes/jquery.min.js', '/javascripts/includes/jquery.base.extend.js', '/javascripts/includes/jquery.curstyles.js' ]
      js :screenshot, '/javscripts/screenshot.js', ['/javascripts/includes/jquery.min.js', '/javascripts/includes/quantize.js', '/javascripts/includes/color-thief.js']
    }

    get '/' do
      erb :home
    end

    get 'all' do
      redirect '/'
    end

    post '/all' do
      erb :all
    end

    get '/colors' do
      @res = `#{settings.phantom_cmd} lib/phantom_lib/base/colors.js #{params[:site]} #{inject_assets}`
      @domaint_colors = @rest_colors = []
      colors = eval(@res)
      if colors
        @domaint_colors = [colors.group_by.sort_by{|ele| ele.length}.uniq.reverse.slice(0)]
        @rest_colors = colors.group_by.sort_by{|ele| ele.length}.uniq.reverse - @domaint_colors
      end
      erb :colors, :layout => false
    end

    get '/typography' do
      @res = `#{settings.phantom_cmd} lib/phantom_lib/base/typography.js #{params[:site]} #{inject_assets}`
      erb :typography, :layout => false
    end

    get '/screenshot' do
      @url = screenshot(params[:site])
      erb :screenshot, :layout => false
    end
  end
end
