module Cynic
  class Response
    attr_reader :body
    def initialize(body)
      @body = body
    end
    def each(&block)
      block.call @body
    end
  end
end