module Meetup
  
  class Group
    
    PATH = '/groups.json'
    
    def initialize(client, options={})      
      @client = client
    end
    
    def by_id(id)
      response = @client.connection.get do |request|
        request.url PATH, :id => id
      end
      results = response.body.results
      results && results.length > 0 ? results.first : nil
    end
    
  end
  
end