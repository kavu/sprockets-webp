# encoding: utf-8

module Sprockets
  module WebP
    class Railtie < ::Rails::Engine
      initializer :webp do |app|
        app.assets.register_postprocessor 'image/jpeg', :jpeg_webp do |context, data|
          Converter.process(app, context, data)
        end

        app.assets.register_postprocessor 'image/png', :png_webp do |context, data|
          Converter.process(app, context, data)
        end
      end
    end
  end
end
