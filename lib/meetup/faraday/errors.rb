module Faraday
  class Response::Errors < Response::Middleware

    begin
      def self.register_on_complete(env)
        env[:response].on_complete do |finished_env|
          case finished_env[:status]
          when 400
              raise Meetup::GeneralError, finished_env[:body]['problem']
            when 401
              raise Meetup::UnauthorizedError, finished_env[:body]['problem']            
            when 500
              raise Meetup::ServerError, 'api.meetup.com is currently down'
          end
        end
      end
    rescue LoadError, NameError => e
      self.load_error = e
    end

    def initialize(app)
      super
      @parser = nil
    end

  end
end
