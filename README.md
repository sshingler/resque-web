# Resque-Web

This is a Sinatra-based front end for seeing what's up with your Resque workers.

## Standalone

If you've installed Resque as a gem running the front end standalone is easy:

    $ resque-web

It's a thin layer around `rackup` so it's configurable as well:

    $ resque-web -p 8282

If you have a Resque config file you want evaluated just pass it to
the script as the final argument:

    $ resque-web -p 8282 rails_root/config/initializers/resque.rb

You can also set the namespace directly using `resque-web`:

    $ resque-web -p 8282 -N myapp

or set the Redis connection string if you need to do something like select a different database:

    $ resque-web -p 8282 -r localhost:6379:2

## Using The front end for failures review

Using the front end to review what's happening in the queue
-----------------------------------------------------------
After using Resque for a while, you may have quite a few failed jobs.
Reviewing them by going over pages when showing 20 a page can be a bit hard.

You can change the param in the url (in the failed view only for now), just add per_page=100 and you will see 100 per page.
for example: http://www.your_domain.com/resque/failed?start=20&per_page=200.


## Passenger

Using Passenger? Resque ships with a `config.ru` you can use. See
Phusion's guide:

Apache: <http://www.modrails.com/documentation/Users%20guide%20Apache.html#_deploying_a_rack_based_ruby_application>
Nginx: <http://www.modrails.com/documentation/Users%20guide%20Nginx.html#deploying_a_rack_app>

## Rack::URLMap

If you want to load Resque on a subpath, possibly alongside other
apps, it's easy to do with Rack's `URLMap`:

``` ruby
require 'resque/server'

run Rack::URLMap.new \
  "/"       => Your::App.new,
  "/resque" => Resque::Server.new
```

Check `examples/demo/config.ru` for a functional example (including
HTTP basic auth).

## Rails 3

You can also mount Resque on a subpath in your existing Rails 3 app by adding `require 'resque/server'` to the top of your routes file or in an initializer then adding this to `routes.rb`:

``` ruby
mount Resque::Server.new, :at => "/resque"
```

If you use Devise, the following will integrate with your existing admin authentication (assuming you have an Admin Devise scope):

``` ruby
resque_constraint = lambda do |request|
  request.env['warden'].authenticate!({ :scope => :admin })
end
constraints resque_constraint do
  mount Resque::Server.new, :at => "/resque"
end
```
