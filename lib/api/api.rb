class Api < Sinatra::Base
  set :version, 'v1'
  use Auth
  use V1
  use Rack::Deflater

  get '/ping.json' do
    {:status => :ok}.to_json
  end
end
