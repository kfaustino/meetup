module Meetup

  class Client

    BASE_URI = 'http://api.meetup.com'

    attr_accessor :api_key

    def initialize(options={})
      self.api_key = options[:api_key] || Meetup.api_key
    end

    def connection
      params = {}
      params[:key] = self.api_key if self.api_key
      
      @connection ||= Faraday::Connection.new(:url => BASE_URI, :params => params, 
        :headers => { :accept =>  'application/json',  :user_agent => 'Meetup Ruby gem'}) do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::MultiJson
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::Errors
      end
    end

  end

end
