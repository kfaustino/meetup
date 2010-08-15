module Meetup

  class Group

    PATH = '/groups.json'

    def initialize(client, options={})
      @client = client
      @options = options
      @results = []
    end

    def by_id(id)
      response = @client.connection.get do |request|
        request.url PATH, :id => id
      end
      results = response.body.results
      results && results.length > 0 ? results.first : nil
    end

    def geolocation(country, city, state)
      @options[:country] = country
      @options[:city] = city
      @options[:state] = state
      self
    end
    
    def limit(value)
      @options[:page] = value.to_s
      self
    end
    
    def radius(value)
      @options[:radius] = value.to_s
      self
    end

    def fetch(force=false)
      if @results.empty? || force
        response = @client.connection.get do |request|
          request.url PATH, @options
        end
        @results = response.body.results
      end
      @results
    end

  end

end
