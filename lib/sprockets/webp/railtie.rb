# frozen_string_literal: true

module Sprockets
  module WebP
    class Railtie < ::Rails::Railtie
      initializer :webp, group: :all do |app|
        app.config.assets.configure do |env|
          env.register_transformer 'image/jpeg', 'image/webp', Converter
          env.register_postprocessor 'image/jpeg', Converter.new(app: app)

          env.register_mime_type 'image/png', '.png'
          env.register_transformer 'image/png', 'image/webp', Converter
          env.register_postprocessor 'image/png', Converter.new(app: app)
        end
      end
    end
  end
end
