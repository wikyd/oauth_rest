require 'rubygems'
require 'oauth'
require 'nokogiri'

module OauthRest
  
  class Session
    
    def initialize(consumer_key, consumer_secret, base_resource_url, access_token = nil, access_token_secret = nil)
      @resource_base = base_resource_url
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site=>@resource_base})
      @oauth_session = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
    end
    
    def request_absolute_resource(resource)
      method_name = resource.sub(/#{@resource_base}\//, '')
      return RestResourceTranslator.new(@oauth_session, nil, method_name).get()
    end
    
    def method_missing(method_name, *args, &block)
      return RestResourceTranslator.new(@oauth_session, nil, method_name)
    end
  end
  
end
