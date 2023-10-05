# frozen_string_literal: true

module Sprockets
  module WebP
    class Railtie < ::Rails::Railtie
      initializer :webp, group: :all do |app|
        app.config.assets.configure do |env|
          evn.register_transformer 'image/jpeg', 'image/webp', Converter
          env.register_bundle_postprocessor 'image/jpeg', :jpeg_webp do |context, data|
            Converter.process(app, context, data)
          end

          env.register_mime_type 'image/png', '.png'
          evn.register_transformer 'image/png', 'image/webp', Converter
          env.register_bundle_postprocessor 'image/png', :png_webp do |context, data|
            Converter.process(app, context, data)
          end
        end
      end
    end
  end
end
