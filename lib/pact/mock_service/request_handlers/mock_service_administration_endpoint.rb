require 'pact/consumer/mock_service/rack_request_helper'

module Pact
  module MockService
    module RequestHandlers
      class MockServiceAdministrationEndpoint

        include Pact::Consumer::RackRequestHelper

        attr_accessor :logger, :name

        def initialize name, logger
          @name = name
          @logger = logger
        end

        def match? env
          has_mock_service_header?(env) && path_matches?(env) && method_matches?(env)
        end

        def has_mock_service_header? env
          env['HTTP_X_PACT_MOCK_SERVICE']
        end

        def path_matches? env
          env['PATH_INFO'].chomp("/") == request_path
        end

        def method_matches? env
          env['REQUEST_METHOD'] == request_method
        end

        def request_path
          raise NotImplementedError
        end

        def request_method
          raise NotImplementedError
        end
      end
    end
  end
end