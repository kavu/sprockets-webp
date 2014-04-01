# encoding: utf-8

require 'sprockets/webp/version'
require 'sprockets/webp/converter'
require 'sprockets/webp/railtie' if defined?(Rails::Engine)

module Sprockets
  module WebP
    # configure web encode options
    #
    # Sprockets::WebP.encode_options = { quality: 90, lossless: 1, method: 5, alpha_filtering: 2 }
    #
    class << self
      attr_writer :encode_options

      def encode_options
        @encode_options ||= { quality: 100, lossless: 1, method: 5, alpha_filtering: 1, alpha_compression: 0, alpha_quality: 100 }
      end
    end
  end
end
