#TODO: Check this authentication
class Auth < Sinatra::Base
  before '/:version/*' do
    if params[:version] == 'v1' || params[:version] == 'v2'
      Api.set :version, params[:version]
    end
    unless request.path =~ /ping\.json$/
      validate_version
      authenticate! unless Rails.env.development?
      set_current_account
    end
  end

  after '/:version/*' do
    if !request.env['HTTP_ACCEPT_ENCODING'].nil? && (request.env['HTTP_ACCEPT_ENCODING'].split(',').include?('gzip') || request.env['HTTP_ACCEPT_ENCODING'].split(',').include?('deflate'))
      content_type 'text/plain'
    else
      content_type :json
    end
  end

  private

  def set_current_account
    Api.set :current_account, Account.find_by_id(request.env['HTTP_CURRENT_ACCOUNT'])
  end

  def authenticate!
    unless params[:key]
      halt 401, { :error => "Missing parameter 'key'" }.to_json
    else
      consumer = ApiConsumer.find_by_access_key(params[:key])
      unless consumer
        halt 401, { :error => "Invalid access key" }.to_json
      else
        Api.set :consumer, consumer
        validate_signature! if Api.environment == :production || Api.environment == :staging
      end
    end
  end

  def validate_signature!
    auth_header = request.env['HTTP_AUTHORIZATION']
    halt 401, { :error => "Missing Authorization header" }.to_json unless auth_header
    params.delete('splat')
    params.delete('version')
    hash = CGI.unescape([ request.request_method, request.url.match(/https?:\/\/[^?]+/)[0], params.to_param ].join('&'))
    hash = CGI.escape(hash)
    hash = OpenSSL::HMAC.digest('sha1', Api.consumer.secret_access_key, hash)
    signature = CGI.escape(Base64.encode64(hash).chomp)
    halt 401, { :error => "Incorrect signature" }.to_json unless signature == auth_header
  end

  def validate_version
    halt 404, { :error => 'API version not found' }.to_json unless params[:version] == Api.version
  end
end

