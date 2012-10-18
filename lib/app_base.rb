require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/contrib'
require 'sinatra/content_for'
require 'helpers/base'
require 'helpers/colors'

require 'RMagick'

class AppBase < Sinatra::Base
  register Sinatra::ConfigFile

  use Rack::CommonLogger

  helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

  configure(:production, :development) do
    enable :logging, :dump_errors, :raise_errors, :show_exceptions, :static
  end

  configure :production do
    require 'newrelic_rpm'
  end

  config_file '../config/config.yml'

  before do
    logger.info params
  end

  get '/ping.json' do
    {:status => :ok}.to_json
  end
end
