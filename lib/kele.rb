require 'httparty'
require 'pp'
require 'json'
require 'roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
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

  def get_mentor_availability(mentor_id = nil)
     get_me if mentor_id.nil?
     id = mentor_id || @current_user_hash["current_enrollment"]["mentor_id"]
     path = "/mentors/#{id}/student_availability"
     response = self.class.get(path, headers: {"authorization" => @auth_token}).body
     @mentor_schedule = JSON.parse(response)
  end

  def get_messages(page_num = nil)

    if page_num.nil?
      response = self.class.get('/message_threads', headers: {"authorization" => @auth_token}).body
      return JSON.parse(response)
    else
      response = self.class.get('/message_threads', body: {"page" => page_num }, headers: {"authorization" => @auth_token}).body
      return JSON.parse(response)
   end

  end

  def create_message(subject, body, options = {})
    get_me if @current_user_hash.nil?
    body = {"sender" => @current_user_hash["email"],
                                        "recipient_id" => options[:recipient_id] ||["current_enrollment"]["mentor_id"],
                                        "subject" => subject,
                                        "stripped-text" => body}
    body["token"] = options[:token] if options[:token]
    response = self.class.post('/messages', body: body,
                                 headers: {"authorization" => @auth_token}).body

   response == " "? "Success": "There was an error posting your message"
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment = nil)
    get_me if @current_user_hash.nil?
    response = self.class.post('/checkpoint_submissions',
                                body: {"assignment_branch" => assignment_branch,
                                        "assignment_commit_link" => assignment_commit_link,
                                        "checkpoint_id" => checkpoint_id,
                                        "comment" => comment,
                                        "enrollment_id" => @current_user_hash["current_enrollment"]["id"]},
                               headers: {"authorization" => @auth_token}).body


  end

  def update_submission(checkpoint_id, id, comment=nil, options={})
    get_me if @current_user_hash.nil?
    path ="/checkpoint_submissions/#{id}"
    response = self.class.put(path,
                                body: {
                                        
                                        "assignment_branch" => options[:assignment_branch],
                                        "assignment_commit_link" => options[:assignment_commit_link],
                                        "checkpoint_id" => checkpoint_id,
                                        "comment" => comment,
                                        "enrollment_id" => @current_user_hash["current_enrollment"]["id"]},
                               headers: {"authorization" => @auth_token}).body


  end




end
