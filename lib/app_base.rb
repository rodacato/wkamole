require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/contrib'
require 'sinatra/content_for'
require 'helpers/base'
require 'helpers/colors'

require 'RMagick'

class AppBase < Sinatra::Base
  register Sinatra::ConfigFile

  helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

  configure(:production, :development) do
    enable :logging, :dump_errors, :raise_errors, :static
  end

  config_file '../config/config.yml'

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
end
