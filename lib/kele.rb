require 'httparty'
require 'pp'
require 'json'

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

  def get_me
    response = self.class.get('/users/me', headers: {"authorization" => @auth_token})
    body = response.body
    @current_user_hash = JSON.parse(body)
  end

  def get_mentor_availability(mentor_id)
     string = mentor_id.to_s
     path = '/mentors/'+ string +'/student_availability'
     response = self.class.get(path, headers: {"authorization" => @auth_token}).body
     @mentor_schedule = JSON.parse(response)
  end

end
