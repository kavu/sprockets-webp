# encoding: utf-8

module SprocketsWebp
  # Register webp postprocessor in Sprockets and fix common issues
  class Sprockets
    def self.register_processor(processor)
      @processor = processor
    end

    # Sprockets 3 and 4 API
    def self.call(input)
      raise input[:environment].inspect
      filename = input[:filename]
      source   = input[:data]
      run(filename, source)
    end

    def self.run(filename, source)
      @processor.process(source, filename)
    end

    # Register postprocessor in Sprockets depend on issues with other gems
    def self.install(env)
      if ::Sprockets::VERSION.to_f < 4
        env.register_postprocessor('image/jpeg',
          ::SprocketsWebp::Sprockets)
        env.register_postprocessor('image/png',
          ::SprocketsWebp::Sprockets)
      else
        env.register_bundle_processor('image/jpeg',
          ::SprocketsWebp::Sprockets)
        env.register_bundle_processor('image/png',
          ::SprocketsWebp::Sprockets)
      end
    end

    # Register postprocessor in Sprockets depend on issues with other gems
    def self.uninstall(env)
      if ::Sprockets::VERSION.to_f < 4
        env.unregister_postprocessor('image/jpeg',
          ::SprocketsWebp::Sprockets)
        env.unregister_postprocessor('image/png',
          ::SprocketsWebp::Sprockets)
      else
        env.unregister_bundle_processor('image/jpeg',
          ::SprocketsWebp::Sprockets)
        env.unregister_bundle_processor('image/png',
          ::SprocketsWebp::Sprockets)
      end
    end

    # Sprockets 2 API new and render
    def initialize(filename, &block)
      @filename = filename
      @source   = block.call
    end

    # Sprockets 2 API new and render
    def render(_, _)
      self.class.run(@filename, @source)
    end
  end
end
