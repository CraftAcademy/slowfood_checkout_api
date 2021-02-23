# frozen_string_literal: true

class Api::MarketsController < ApplicationController
  def index 
    response = RestClient.get("https://api.nomics.com/v1/market-cap/history?key=aaf997cff4f9e722484a7a24ca78e9d3&start=#{params['start']}")
    response_as_json = JSON.parse(response.body)
    response_as_json.each do |cap|
      date = DateTime.parse(cap['timestamp']).strftime('%d/%m')
      cap['timestamp'] = date
    end
    render json: { market_caps: response_as_json }
  end
end
