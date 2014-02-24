module Cynic
  class Response
    attr_reader :body, :content_type, :headers, :status
    
    def initialize(body, request)
      @body = body
      @content_type = set_content_type(request)
    end
    
    def each(&block)
      block.call @body
    end
    
    def status
      200
    end
    
    def set_content_type(request)
      if request.params.has_key? "format"
        "text/#{request.params['format']}"
      else
        request.content_type =~ /text/ ? request.content_type : "text/html"
      end
    end
    
    def headers
      {"CONTENT-TYPE" => content_type}
    end
    
    def send
      [status, headers, self]
    end
    
  end
end