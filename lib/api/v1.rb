require 'api/path_namespace'
require 'api/version1/colors'
require 'helpers/base'

module Api
  class V1 < Sinatra::Base
    extend PathNamespace
    path_namespace 'api/v1'

    register Version1::Colors

    helpers Sinatra::ContentFor, Helpers::Base, Helpers::Colors

    configure(:production, :development) do
      enable :logging, :dump_errors, :static, :show_exceptions
      disable :raise_errors
    end
  end
end
