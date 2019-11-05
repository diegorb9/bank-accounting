# frozen_string_literal: true

module RequestMacros
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def basic_headers(token)
    {
      'Accept' => Mime[:json].to_s,
      'Content-type' => Mime[:json].to_s,
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token
        .encode_credentials(token)
    }
  end

  def basic_headers_without_authorization
    basic_headers(nil).except('HTTP_AUTHORIZATION')
  end
end
