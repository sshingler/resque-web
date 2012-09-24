module Resque
  module Web
    unless defined?(::Resque::Web::VERSION)
      VERSION = "0.0.1".freeze
    end
  end
end