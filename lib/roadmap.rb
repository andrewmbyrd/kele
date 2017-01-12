module Roadmap

def get_roadmap(roadmap_id)
  path = '/roadmaps/' + roadmap_id.to_s
  response = self.class.get(path, headers: {"authorization" => @auth_token}).body
  @roadmap = JSON.parse(response)
end

def get_checkpoint(checkpoint_id)
  path = '/checkpoints/' + checkpoint_id.to_s
  response = self.class.get(path, headers: {"authorization" => @auth_token}).body
  @checkpoint = JSON.parse(response)
end

end
