module Helpers
  module Base
    def base_url
      @base ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

    def inject_assets
      url('javascripts/inject.js')
    end

    def url(path='')
      [base_url, path].join('/')
    end
  end
end
