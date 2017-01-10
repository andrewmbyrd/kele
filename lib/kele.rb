require 'httparty'
require 'pp'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(uname, pword)
    @auth = {email: uname, password: pword}
    @auth_token = self.class.post('/sessions', @auth)
  end

  def auth_token
    @auth_token
    #you can do auth_token['errors'] to see if there was any problem with the self.class.post request
  end

  def self.hi
     puts @auth_token
  end

end
