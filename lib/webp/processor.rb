# encoding: utf-8
require 'logger'
require 'tempfile'
require 'webp-ffi'

module SprocketsWebp
  class Processor
    def initialize(assets, options = {})
      @assets  = assets
      @options = options
      @logger  = self.class.default_logger
    end

    # Process `image` and return result.
    def process(data, filename)
      raise @assets['1.png'].inspect
      output_path = File.join(
        @assets.root,
        'public',
        @assets.context_class.assets_prefix,
        "#{@assets[File.basename(filename)].digest_path}.webp"
      )
      raise output_path.inspect
      Tempfile.open ["sprockets-webp", "webp"] do |file|
        file.binmode
        file.write data
        file.close

        encode_to_webp(file.path, output_path)
      end
      nil
    end

    private

    def encode_to_webp(image_file, webp_file)
      ::WebP.encode(image_file, webp_file, @options)
      @logger.info "Webp converted image #{webp_file}"
    rescue => e
      @logger.warn "Webp convertion error of image #{webp_file}. Error info: #{e.message}"
    end

    def self.default_logger
      logger = Logger.new($stderr)
      logger.level = Logger::FATAL
      logger
    end
  end
end
