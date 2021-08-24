require 'rails_helper'

RSpec.describe "Insights", type: :request do
  user = User.create!(
    first_name: "Churro", 
    last_name: "Chuong", 
    avatar_url: "https://happydogeface.com",
    occupation: "First Protector", 
    created_at: Date.new, 
    updated_at: Date.new)

  describe "GET /insights/summaries" do
    before :each do
      event_stubs = [
        {time: '2021-01-01', event_type: 'impression', revenue: 100},
        {time: '2021-01-02', event_type: 'impression', revenue: 100},
        {time: '2021-01-01', event_type: 'conversion', revenue: 300},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300},
      ]

      event_stubs.each do |event|
        MetricEvent.create!(
          time: event[:time], 
          user_id: user.id,
          event_type: event[:event_type],
          revenue: event[:revenue],
          created_at: Date.new, 
          updated_at: Date.new)
      end
    end

    it "returns insight summaries" do
      get '/insights/summaries'

      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body) 
      
      actual_insight = parsed_response[0]
      expect(actual_insight["first_name"]).to eq("Churro")
      expect(actual_insight["last_name"]).to eq("Chuong")
      expect(actual_insight["avatar_url"]).to eq("https://happydogeface.com")
      expect(actual_insight["occupation"]).to eq("First Protector")
      expect(actual_insight["total_conversions"]).to eq(2)
      expect(actual_insight["total_impressions"]).to eq(2)
      expect(actual_insight["total_revenue"]).to eq(800)
      expect(actual_insight["date_start"]).to eq("2021-01-01T00:00:00.000Z")
      expect(actual_insight["date_end"]).to eq("2021-01-02T00:00:00.000Z")
    end
  end

  describe "GET /insights/dailyconversions/:user_id" do
    before :each do
      event_stubs = [
        {time: '2021-01-01', event_type: 'conversion', revenue: 300},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300},
      ]

      event_stubs.each do |event|
        MetricEvent.create!(
          time: event[:time], 
          user_id: user.id,
          event_type: event[:event_type],
          revenue: event[:revenue],
          created_at: Date.new, 
          updated_at: Date.new)
      end
    end

    it "returns daily conversions for one user" do
      get "/insights/dailyconversions/#{user.id}"

      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body) 
      
      actual_conversion1 = parsed_response[0]
      expect(actual_conversion1["daily_conversions"]).to eq(1)
      expect(actual_conversion1["date"]).to eq("2021-01-01T00:00:00.000Z")

      actual_conversion2 = parsed_response[1]
      expect(actual_conversion2["daily_conversions"]).to eq(2)
      expect(actual_conversion2["date"]).to eq("2021-01-02T00:00:00.000Z")
    end
  end
end
