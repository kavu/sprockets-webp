# encoding: utf-8

require 'tempfile'
require 'logger'
require 'fileutils'
require 'webp-ffi'

module Sprockets
  module WebP
    class Converter
      class << self

        attr_reader :context

        def process(app, context, data)
          @context = context
          # Application Config alias
          config = app.config.assets

          # If Application Assets Digests enabled - Add Digest
          webp_file = webp_file_by_config(config, data)

          # WebP File Pathname
          webp_path = Pathname.new File.join(app.root, 'public', config.prefix, webp_file)

          # Create Directory for both Files, unless already exists
          FileUtils.mkdir_p(webp_path.dirname) unless Dir.exists?(webp_path.dirname)

          # encode to webp
          encode_to_webp(data, webp_path.to_path, webp_file) unless ::File.exist?(webp_path.to_path)

          data
        end

        private

        def webp_file_by_config(config, data)
          digest    = config.digest ? "-#{context.environment.digest_class.new.update(data).to_s}" : nil
          file_name = context.logical_path # Original File name w/o extension
          file_ext  = context.pathname.extname # Original File extension
          logger.info '********************************************************************************'
          logger.info context
          logger.info file_name
          logger.info file_ext
          logger.info context.pathname
          logger.info digest
          logger.info '********************************************************************************'
          "#{file_name}#{digest}#{file_ext}.webp" # WebP File fullname
        end

        def encode_to_webp(data, webp_path, webp_file = "")
          # Create Temp File with Original File binary data
          Tempfile.open('webp') do |file|
            file.binmode
            file.write(data)
            file.close

            # Encode Original File Temp copy to WebP File Pathname
            begin
              ::WebP.encode(file.path, webp_path, Sprockets::WebP.encode_options)
              logger.info "Webp converted image #{webp_path}"
            rescue => e
              logger.warn "Webp convertion error of image #{webp_file}. Error info: #{e.message}"
            end
          end
        end

        def logger
          if @context && @context.environment
            @context.environment.logger
          else
            logger = Logger.new($stderr)
            logger.level = Logger::FATAL
            logger
          end
        end

      end
    end
  end
end
