require 'app_base'

require 'api/path_namespace'
require 'api/version1/colors'
require 'helpers/base'

module Api
  class V1 < AppBase
    extend PathNamespace
    path_namespace 'api/v1'

    set :root, File.dirname(__FILE__)
    set :views, Proc.new { File.join(settings.root, "views") }

    register Version1::Colors
  end
end
