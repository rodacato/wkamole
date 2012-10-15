module Helpers
  module Colors
    def screenshot(site)
      image_name = rand(36**10).to_s(36)
      `#{settings.phantom_cmd} #{settings.root}/lib/screenshot.js #{params[:site]} #{settings.root}/public/images/screenshots/#{image_name}.jpg`
      url("images/screenshots/#{image_name}.jpg")
    end
  end
end
