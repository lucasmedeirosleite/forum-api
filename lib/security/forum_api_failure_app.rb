# frozen_string_literal: true

class ForumAPIFailureApp < Devise::FailureApp
  def http_auth_body
    return super unless request_format == :json
    
    {
      sucess: false,
      message: 'Authentication failed'
    }.to_json
  end
end