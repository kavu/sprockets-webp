# encoding: utf-8

module Sprockets
  module WebP
    class Railtie < ::Rails::Railtie
      initializer :webp, group: :all do |app|
        app.config.assets.configure do |env|
          env.register_mime_type 'image/jpeg', '.jpeg'
          env.register_postprocessor 'image/jpeg', :jpeg_webp do |context, data|
            Converter.process(app, context, data)
          end

          env.register_mime_type 'image/png', '.png'
          env.register_postprocessor 'image/png', :png_webp do |context, data|
            Converter.process(app, context, data)
          end
        end
      end
    end
  end
end
