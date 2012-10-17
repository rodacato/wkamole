module Version1
  module Colors

    def self.registered(app)
      app.get '/colors.json' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]
        explicit = `#{WkaMole::Extractor.settings.phantom_cmd} lib/phantom_lib/base/colors.js #{params[:site]} #{inject_assets}`
        colors = build_colors(explicit)

        {explicit: colors}.to_json
      end

      app.get '/colors-implicit.json' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]

        implicit = `#{WkaMole::Extractor.settings.phantom_cmd} lib/phantom_lib/base/colors-implicit.js #{base_url}/api/v1/colors-implicit?site=#{params[:site]}`
        #colors = build_colors(implicit)
        
        {implicit: implicit}.to_json
      end

      app.get '/colors-implicit' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]
        @url = screenshot(params[:site])
        erb :testing
      end

    end

  end
end

