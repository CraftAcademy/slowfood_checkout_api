RSpec.describe "GET/api/products" do
  let!(:products){3.times{create(:product)}}

  describe "successfully get list of products" do
    before do
      get "/api/products"
    end

    it "expected to return a 200 response" do
      expect(response).to have_http_status 200
    end

    it "expected to return all products" do
      expect(response_json["products"].count).to eq 3
    end

    it "expected to return the products names" do
      expect(response_json["products"].first['name']).to eq 'Vesuvio'
    end
  end
end 