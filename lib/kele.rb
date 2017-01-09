dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'httparty')
require 'pp'

class Kele
  include HTTParty


  def initialize(uname, pword)
    @base_uri = 'https://www.bloc.io/api/v1'
    @auth = {username: uname, password: pword}
    @auth_token = self.class.post('/sessions', @auth)
  end

  def auth_token
    @auth_token
    #you can do auth_token['errors'] to see if there was any problem with the self.class.post request
  end

  def self.hi
     "Hello World"
  end

end
