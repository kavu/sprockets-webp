# Sprockets::WebP

[![unstable](https://rawgithub.com/hughsk/stability-badges/master/dist/unstable.svg)](http://github.com/hughsk/stability-badges)

[![Gem Version](https://badge.fury.io/rb/sprockets-webp.png)](http://badge.fury.io/rb/sprockets-webp)
[![Code Climate](https://codeclimate.com/github/kavu/sprockets-webp.png)](https://codeclimate.com/github/kavu/sprockets-webp)
[![Dependency Status](https://gemnasium.com/kavu/sprockets-webp.png)](https://gemnasium.com/kavu/sprockets-webp)
[![Still Maintained](http://stillmaintained.com/kavu/sprockets-webp.png)](http://stillmaintained.com/kavu/sprockets-webp)

[![Coderwall](https://api.coderwall.com/kavu/endorsecount.png)](https://coderwall.com/kavu)

This gem provides a Rails Asset Pipeline hook for converting PNG and JPEG assets to the WebP format.

## Requirements

The main requirement is obviously [libwebp](https://developers.google.com/speed/webp/) itself. Please, consult the [webp-ffi](https://github.com/le0pard/webp-ffi) README for the installation instructions.

## Installation

If you're using Rails 4 you need to add gem to the ```:production``` group in to your application's Gemfile:

```ruby
group :production do
  # ...
  gem 'sprockets-webp'
  # ...
end
```

In case of Rails 3, add it to the ```:assets``` group:

```ruby
group :assets do
  # ...
  gem 'sprockets-webp'
  # ...
end
```

And then execute:

    $ bundle

Drop some PNGs and JPGs into ```app/assets/images``` and you can test converter locally with the Rake task:

    $ bundle exec rake assets:precompile RAILS_ENV=production

### Rails 3 Notice

Minimal required version of Rails 3 is ```3.2.9```, because of Sprockets ```~> 2.2``` dependency requirement. In Rails 4 it just works.

## Configuration

You can configure encode options for webp by using encode_options:

    Sprockets::WebP.encode_options = { quality: 90, lossless: 1, method: 5, alpha_filtering: 2 }

More options you can find in [web-ffi readme](https://github.com/le0pard/webp-ffi#encode-webp-image).

## Capistrano deploy

If you deploy your rails app by capistrano gem, you should update mtime for your webp images, because it will not present in manifest.json and will be cleanup automatically. To solve this problem you can use this capistrano task:

```ruby
after "deploy:update", "deploy:webp:touch"

load do

  namespace :deploy do

    namespace :webp do

      desc <<-DESC
        [internal] Updates mtime for webp images
      DESC
      task :touch, :roles => :app, :except => { :no_release => true } do
        run <<-CMD.compact
          cd -- #{shared_path.shellescape}/#{shared_assets_prefix}/ &&
          for asset in $(
            find . -regex ".*\.webp$" -type f | LC_COLLATE=C sort
          ); do
            echo "Update webp asset: $asset";
            touch -c -- "$asset";
          done
        CMD
      end

    end

  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
