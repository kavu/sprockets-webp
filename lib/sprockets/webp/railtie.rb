module Sprockets
  module WebP
    class Railtie < Rails::Engine
      initializer 'sprockets.webp', after: 'sprockets.environment' do |app|
        next if app.config.assets.compile
        assets = app.assets

        assets.register_mime_type 'image/png',  '.png'
        assets.register_mime_type 'image/jpeg', '.jpg'

        assets.register_postprocessor 'image/jpeg', :jpeg_webp do |context, data|
          Converter.process(app, context, data)
        end

        assets.register_postprocessor 'image/png', :png_webp do |context, data|
          Converter.process(app, context, data)
        end
      end
    end
  end
end
