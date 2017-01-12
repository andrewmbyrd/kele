require 'httparty'
require 'pp'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  attr_accessor :auth_token

  def initialize(uname, pword)
    @auth = {email: uname, password: pword}
    response = self.class.post('/sessions', body: @auth)
    unless response['auth_token'].nil?
      @auth_token = response['auth_token']
    else
      raise ArgumentError, response['message']
    end

  end

  def auth_token
    @auth_token
    #you can do auth_token['errors'] to see if there was any problem with the self.class.post request
  end

  def self.hi
     puts @auth_token
  end

end
