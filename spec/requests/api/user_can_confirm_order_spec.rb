# frozen_string_literal: true

RSpec.describe 'PUT /api/orders/:id', type: :request do
  let(:user) { create(:user) }
  let(:authentication_headers) { user.create_new_auth_token }
  let(:order) { create(:order, user: user) }
  let(:ordered_product) { create(:product) }

  describe 'successfully with valid params' do
    before do
      order.items.create(product: ordered_product)
      put "/api/orders/#{order.id}",
          params: { confirmed: true },
          headers: authentication_headers
    end

    it 'is expected to return 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'Your order is confirmed and will be ready to pick up in 15 min to a quarter'
    end

    it 'is expected to update the confirmed status of order' do
      expect(order.reload.confirmed?).to eq true
    end
  end
end
