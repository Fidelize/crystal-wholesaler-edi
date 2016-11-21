require "jwt"

module Edi
  module Controller
    class ApplicationController
      def initialize(@env : HTTP::Server::Context)
        @env.response.content_type = "application/json"
      end

      protected def authenticated?
        begin
          authorization_header = @env.request.headers["Authorization"]
          token = authorization_header.split(' ').last
          payload, header = JWT.decode(token, "secret", "HS256")
          return true
        rescue
          return false
        end
      end
    end
  end
end
