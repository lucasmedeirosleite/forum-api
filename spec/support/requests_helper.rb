# frozen_string_literal: true

module RequestsHelper
  def authenticate(user:)
    params = {
      user: {
        email: user.email,
        password: user.password
      }
    }
    
    post(user_session_path, params: params)
    response.headers['Authorization']
  end

  def private_get(path, params: {}, token:)
    get(path, params: params, headers: private_headers(token))
  end

  def private_post(path, params: {}, token:)
    post(path, params: params.to_json, headers: private_headers(token))
  end

  def private_patch(path, params: {}, token:)
    patch(path, params: params.to_json, headers: private_headers(token))
  end

  def private_delete(path, token:)
    delete(path, headers: private_headers(token))
  end

  def private_headers(token, api_version: 1)
    {
      'Content-Type' => 'application/json',
      'Authorization' => token,
      'Accept' => "application/vnd.forum.com; version=#{api_version}"
    }
  end
end
