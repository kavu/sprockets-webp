# encoding: utf-8

require 'tempfile'
require 'fileutils'
require 'webp-ffi'

module Sprockets
  module WebP
    class Converter
      def self.process(app, context, data)
        # Application Config alias
        config = app.config.assets

        # If Application Assets Digests enabled - Add Digest
        digest    = config.digest ? "-#{context.environment.digest.update(data).hexdigest}" : nil
        file_name = context.logical_path # Original File name w/o extension
        file_ext  = context.pathname.extname # Original File extension
        webp_file = "#{file_name}#{digest}#{file_ext}.webp" # WebP File fullname

        # WebP File Pathname
        webp_path = Pathname.new File.join(app.root, 'public', config.prefix, webp_file)

        # Create Directory for both Files, unless already exists
        FileUtils.mkdir_p(webp_path.dirname) unless Dir.exists?(webp_path.dirname)

        # Create Temp File with Original File binary data
        Tempfile.open('webp') do |file|
          file.binmode
          file.write(data)
          file.close

          # Encode Original File Temp copy to WebP File Pathname
          ::WebP.encode(file.path, webp_path.to_path) rescue nil
        end

        data
      end
    end
  end
end
