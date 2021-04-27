# frozen_string_literal: true

RSpec.describe 'POST /api/orders', type: :request do
  describe 'Successfully' do
    let(:product) { create(:product) }
    let!(:second_product) { create(:product, name: 'Kebab Pizza')}
    let(:user) { create(:user) }
    let(:auth_headers) { user.create_new_auth_token }

    before do
      post '/api/orders',
           params: {
             product_id: product.id
           },
           headers: auth_headers
    end

    it 'is expected to return a 201 status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'This pizza was added to your order!'
    end

    it 'is expected to return an array of items' do
      expect(response_json['order']['items'].count).to eq 1
    end

    it 'is expected to return the name of the product in the order' do
      expect(response_json['order']['items'].first['name']).to eq 'Vesuvio'
    end
  end
end
