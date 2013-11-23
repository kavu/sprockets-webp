# encoding: utf-8

require 'sprockets/webp/version'
require 'sprockets/webp/converter'
require 'sprockets/webp/railtie' if defined?(Rails::Engine)

module Sprockets
  module WebP
    extend self

    # configure
    #
    # Sprockets::WebP.encode_options = { quality: 90, lossless: 1, method: 5, alpha_filtering: 2 }
    #
    # or
    #
    # Sprockets::WebP.configure do |config|
    #   config.encode_options = { quality: 90, lossless: 1, method: 5, alpha_filtering: 2 }
    # end

    attr_writer :encode_options

    def configure
      yield self
    end

    def encode_options
      @encode_options ||= { quality: 90, lossless: 1, method: 5, alpha_filtering: 2 }
    end
  end
end