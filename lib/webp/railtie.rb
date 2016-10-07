# encoding: utf-8

module SprocketsWebp
  class Railtie < ::Rails::Railtie

    if config.respond_to?(:assets) and not config.assets.nil?
      config.assets.configure do |env|
        SprocketsWebp.install(env)
      end
    else
      initializer :setup_webp, group: :all do |app|
        if defined? app.assets and not app.assets.nil?
          SprocketsWebp.install(app.assets)
        end
      end
    end

  end
end
