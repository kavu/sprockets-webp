# Sprockets::WebP

This gem provides a Rails Asset Pipeline hook for converting PNG and JPEG assets to WebP format.

## Requirements

The main requirement is obviously [libwebp](https://developers.google.com/speed/webp/) itself. Please, consult the [webp-ffi](https://github.com/le0pard/webp-ffi) README for the installation instructions.

## Installation

If you're using Rails 4 you need to add gem to the ```:production``` group in to your application's Gemfile:

    group :produciton do
      # ...
      gem 'sprockets-webp'
      # ...
    end

In case of Rails 3, add it to the ```:assets``` group:

    group :assets do
      # ...
      gem 'sprockets-webp'
      # ...
    end

And then execute:

    $ bundle

Drop some PNGs and JPGs into ```app/assets/images``` and you can test converter locally with the Rake task:

    $ bundle exec rake assets:precompile RAILS_ENV=production

### Rails 3 Notice

Minimal required version of Rails 3 is ```3.2.9```, because of Sprockets ```~> 2.2``` dependency requirement.

### Rails 4 Notice

I don't have any Rails 4 live apps right now, so I can't test this gem in "real", non synthetic, environment. So, if you have some problems, ideas or suggestions caused your Rails 4 application, please, feel free to contact me.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
