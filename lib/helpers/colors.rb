module Helpers
  module Colors
    def screenshot(site)
      image_name = rand(36**10).to_s(36) + '.png'
      `#{WkaMole::Extractor.settings.phantom_cmd} --load-images=no #{WkaMole::Extractor.settings.root}/lib/phantom_lib/base/screenshot.js #{params[:site]} #{WkaMole::Extractor.settings.root}/public/images/screenshots/#{image_name}`
      url("images/screenshots/#{image_name}")
    end

    def build_colors(val)
      colors = eval(val)
      weighted = colors.group_by.map{|e| [e, e.length]}.uniq.sort{|a,b| b[1] <=> a[1]}
      weigthed = weighted.map{|e| /(\d{1,}, ?\d{1,}, ?\d{1,})/.match(e[0]); $1; }
    end
  end
end
