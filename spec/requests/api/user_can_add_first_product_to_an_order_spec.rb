# frozen_string_literal: true

RSpec.describe 'POST /api/orders', type: :request do
  describe 'Successfully with valid product id' do
    let!(:pizza_to_order) { create(:product) }
    let!(:user) { create(:user) }
    let!(:authorisation_headers) { user.create_new_auth_token }

    before do
      post '/api/orders',
           params: {
             product_id: pizza_to_order.id
           },
           headers: authorisation_headers
    end

    it 'is expected to return 201 status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'This pizza was added to your order!'
    end

    it 'is expected to return an array of the items' do
      expect(response_json['order']['items'].count).to eq 1
    end

    it 'is expected to return the products of the order' do
      expect(response_json['order']['items'].first['name']).to eq 'Vesuvio'
    end
  end
end
