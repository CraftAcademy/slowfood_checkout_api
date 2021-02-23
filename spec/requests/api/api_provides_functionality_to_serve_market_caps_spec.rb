RSpec.describe 'GET /api/markets' do
  describe 'successfully with valid params' do
    before do
      get '/api/markets',
      params: {
        start: '2021-02-15T13:29:31.070Z'
      }
    end

    it 'is expected to have a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the market caps from the last week' do
      expect(response_json['market_caps'].count).to eq 7
    end

    it 'is expected to return formatted timestamp' do
      expect(response_json['market_caps'].first['timestamp']).to eq '16/02'
    end
  end
end