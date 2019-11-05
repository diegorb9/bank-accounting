# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'unauthorizable request' do |method, url, url_params|
  let(:url_path) { public_send(url, url_params) }

  context 'without minimum requirements' do
    it 'returns not unauthorized status code when not authenticated' do
      public_send(method, url_path,
                  params: {},
                  headers: basic_headers_without_authorization)

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
