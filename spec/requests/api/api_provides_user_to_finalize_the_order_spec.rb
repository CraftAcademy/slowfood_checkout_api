# frozen_string_literal: true

RSpec.describe 'PUT /api/orders/:id', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  let(:order) { create(:order, user_id: user.id) }
  let(:ordered_pizza) { create(:product) }
  describe 'successfully with valid params' do
    before do
      order.order_items.create(product_id: ordered_pizza.id)
      put "/api/orders/#{order.id}",
          params: { finalized: true },
          headers: auth_headers
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'Your order will be ready to pick up in 15 minutes to a quarter'
    end

    it 'is expected to update the order to be finalized' do
      expect(order.reload.finalized?).to eq true
    end
  end
end
