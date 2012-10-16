module Version1
  module Colors

    def self.registered(app)
      app.helpers Bands::Helpers

      app.get '/colors.json' do
        get_bands
      end

    end

  end
end

