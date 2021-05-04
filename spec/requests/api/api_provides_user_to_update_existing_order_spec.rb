# frozen_string_literal: true

RSpec.describe 'PUT /api/orders/:id' do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:ordered_pizza) { create(:product) }
  let(:pizza_to_order) { create(:product, name: 'Calzone') }

  describe 'successfully with valid params' do
    let(:order) { create(:order, user_id: user.id) }
    before do
      order.order_items.create(product_id: ordered_pizza.id)
      put "/api/orders/#{order.id}",
          params: { product_id: pizza_to_order.id },
          headers: auth_headers
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to have two items in the order' do
      expect(response_json['order']['items'].count).to eq 2
    end

    it 'is expected to be a Calzone in the order' do
      expect(response_json['order']['items'].second['name']).to eq 'Calzone'
    end
  end

  describe 'unsuccessfully' do
    let(:order) { create(:order, user_id: user.id, finalized: true) }

    describe 'when order has been finalized' do
      before do
        put "/api/orders/#{order.id}",
            params: { product_id: pizza_to_order.id },
            headers: auth_headers
      end

      it 'is expected to return a 403 status' do
        expect(response).to have_http_status 403
      end

      it 'is expected to return an error message' do
        expect(response_json['message']).to eq "This order has already been confirmed, if you are still hungry, create a new order!"
      end
    end
  end
end
