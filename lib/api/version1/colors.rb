module Version1
  module Colors

    def self.registered(app)
      app.get '/colors.json' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]

        explicit = `#{WkaMole::Extractor.settings.phantom_cmd} lib/phantom_lib/base/colors.js #{params[:site]} #{inject_assets}`
        colors1 = build_colors(explicit)

        url = screenshot(params[:site])
        img = Magick::ImageList.new(url)
        colors2 = img.color_histogram.map{|pixel| pixel.first.to_color(Magick::AllCompliance, false, 8, true) }

        {explicit: colors1, implicit: colors2}.to_json
      end

      app.get '/colors-explicit.json' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]
        explicit = `#{WkaMole::Extractor.settings.phantom_cmd} lib/phantom_lib/base/colors.js #{params[:site]} #{inject_assets}`
        colors = build_colors(explicit)

        {explicit: colors}.to_json
      end

      app.get '/colors-implicit.json' do
        halt 401, { :error => "Missing parameter 'site'" }.to_json unless params[:site]
        url = screenshot(params[:site])

        img = Magick::ImageList.new(url)
        colors = img.color_histogram.map{|pixel| pixel.first.to_color(AllCompliance, false, 8, true) }
        {implicit: colors}.to_json
      end

    end

  end
end

