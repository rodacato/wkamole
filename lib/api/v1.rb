class V1 < Sinatra::Base
  extend PathNamespace
  path_namespace 'v1'

  register Version1::Stations

  set :raise_errors, Proc.new { false }
  set :show_exceptions, false

  error ActiveRecord::RecordNotFound do
    halt 404, { :error => 'Record Not Found'}.to_json
  end

  error ActiveRecord::RecordInvalid do
    halt 422, { :errors => @resource.errors }.to_json
  end

end
