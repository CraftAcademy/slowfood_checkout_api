# frozen_string_literal: true

RSpec.describe 'PUT /api/orders/:id', type: :request do
  let(:registered_user) { create(:user) }
  let(:auth_headers) { registered_user.create_new_auth_token }
  let(:ordered_pizza) { create(:product) }
  let(:pizza_to_order) { create(:product, name: 'Funghi') }

  describe 'successfully with valid params' do
    let(:order) { create(:order, user: registered_user) }
    before do
      order.items.create(product: ordered_pizza)
      put "/api/orders/#{order.id}",
          params: { product_id: pizza_to_order.id },
          headers: auth_headers
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to have to have a product called Funghi' do
      expect(response_json['order']['items'].second['name']).to eq 'Funghi'
    end

    it 'is expected to have two products in the order' do
      expect(response_json['order']['items'].count).to eq 2
    end
  end

  describe 'unsuccessfully if order is confirmed' do
    let(:order) { create(:order, user: registered_user, confirmed: true) }
    before do
      order.items.create(product: ordered_pizza)
      put "/api/orders/#{order.id}",
          params: { product_id: pizza_to_order.id },
          headers: auth_headers
    end

    it 'is expected to return 403' do
      expect(response).to have_http_status 403
    end

    it 'is expected to return error message' do
      expect(response_json['message']).to eq 'This order has already been confirmed, to order more food, create a new order'
    end
  end
end
