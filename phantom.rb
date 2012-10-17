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
    }

    get '/' do
      erb :home
    end

    get 'all' do
      redirect '/'
    end

    post '/all' do
      @res = `#{settings.phantom_cmd} lib/phantom_lib/base/typography.js #{params[:site]} #{inject_assets}`
      erb :all
    end
  end
end
