require 'tempfile'
require 'logger'
require 'fileutils'
require 'webp-ffi'
require 'fastimage'

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
          full_file_name = context.pathname.to_path

          "#{file_name}#{digest}#{dimensions(full_file_name)}#{file_ext}.webp" # WebP File fullname
        end

        def dimensions(filename)
          d = image_width_x_height(filename)

          "#{'-' if d}#{d}"
        end

        def image_width_x_height(filename)
          FastImage.size(filename)&.join('x')
        end

        def encode_to_webp(data, webp_path, webp_file = '')
          # Create Temp File with Original File binary data
          Tempfile.open('webp') do |file|
            file.binmode
            file.write(data)
            file.close

            # Encode Original File Temp copy to WebP File Pathname
            begin
              ::WebP.encode(file.path, webp_path, Sprockets::WebP.encode_options)
              logger.info "Webp converted image #{webp_path}"
            rescue StandardError => e
              logger.warn "Webp convertion error of image #{webp_file}. Error info: #{e.message}"
            end
          end
        end

        def logger
          if @context&.environment
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
