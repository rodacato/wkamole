module Helpers
  module Colors
    def screenshot(site)
      image_name = rand(36**10).to_s(36) + '.png'
      `#{WkaMole::Extractor.settings.phantom_cmd} --load-images=no #{WkaMole::Extractor.settings.root}/lib/phantom_lib/base/screenshot.js #{params[:site]} #{WkaMole::Extractor.settings.root}/public/images/screenshots/#{image_name}`
      url("images/screenshots/#{image_name}")
    end

    def build_explicit_colors(val, implicit_colors = nil)
      colors = JSON.parse(val)

      colors['colors'] = colors['colors'].compact.group_by.map{|e| [e, e.length]}.uniq.sort{|a,b| b[1] <=> a[1]}.map{|e| e[0].upcase }
      colors['background-colors'] = colors['background-colors'].compact.group_by.map{|e| [e, e.length]}.uniq.sort{|a,b| b[1] <=> a[1]}.map{|e| e[0].upcase }
      colors['borders'] = colors['borders'].compact.group_by.map{|e| [e, e.length]}.uniq.sort{|a,b| b[1] <=> a[1]}.map{|e| e[0].upcase }

      if implicit_colors
        colors['colors'] = colors['colors'] & implicit_colors
        colors['background-colors'] = colors['background-colors'] & implicit_colors
        colors['borders'] = colors['borders'] & implicit_colors
      end

      colors
    end
  end
end
