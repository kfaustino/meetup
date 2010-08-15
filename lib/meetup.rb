require 'hashie'
require 'faraday'
require 'multi_json'
require 'faraday_middleware'

Hash.send :include, Hashie::HashExtensions

module Meetup
  extend self
    
  autoload :Client, 'meetup/client'
  autoload :Group, 'meetup/group'

  attr_accessor :api_key
  
  def configure
    yield self
  end
  
end