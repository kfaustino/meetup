module Faraday
  class Response::UTFEncoder < Response::Middleware

    begin
      require 'iconv'

      def self.register_on_complete(env)
        env[:response].on_complete do |finished_env|
          finished_env[:body] = Iconv.conv('utf-8', 'ISO-8859-1', finished_env[:body])
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
