require 'hashie'
require 'faraday'
require 'multi_json'
require 'faraday_middleware'
require File.join(File.dirname(__FILE__), 'meetup', 'faraday')

Hash.send :include, Hashie::HashExtensions

module Meetup
  extend self

  class UnauthorizedError < StandardError; end
  class GeneralError < StandardError; end
  class ServerError < StandardError; end

  autoload :Client, 'meetup/client'
  autoload :Group, 'meetup/group'

  attr_accessor :api_key

  def configure
    yield self
  end

end
