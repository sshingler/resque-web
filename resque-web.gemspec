# -*- encoding: utf-8 -*-
require File.expand_path("../lib/resque-web/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "resque-web"
  gem.version     = Resque::Web::VERSION.dup
  gem.author      = "Steven Shingler"
  gem.email       = "shingler@gmail.com"
  gem.homepage    = "https://github.com/sshingler/resque-web"
  gem.summary     = %q{Resque Web}
  gem.description = %q{An interface for monitoring queues, jobs, and workers in Resque}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.require_paths = ["lib"]

  gem.add_dependency "resque"
  gem.add_dependency "vegas"
  gem.add_dependency "sinatra"
  gem.add_dependency "multi_json"
end
