# encoding: utf-8
require_relative 'webp/version'
require_relative 'webp/sprockets'
require_relative 'webp/processor'
require_relative 'webp/railtie' if defined?(Rails)

DEFAULT_WEBP_OPTIONS = {quality: 100, lossless: 1, method: 6, alpha_filtering: 2, alpha_compression: 0, alpha_quality: 100}

module SprocketsWebp
  attr_writer :encode_options

  def self.encode_options
    @encode_options ||= DEFAULT_WEBP_OPTIONS
  end

  # Add SprocketsWebp for Sprockets environment in `assets`.
  def self.install(assets)
    Sprockets.register_processor(processor(assets, encode_options))
    Sprockets.install(assets)
  end

  # Disable installed Sprockets::Webp
  def self.uninstall(assets)
    Sprockets.uninstall(assets)
  end

  # Cache processor instances
  def self.processor(assets, options = DEFAULT_WEBP_OPTIONS)
    Processor.new(assets, options)
  end
end


