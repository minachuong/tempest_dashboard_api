require 'rails_helper'

RSpec.describe "Insights", type: :request do
  user1 = User.create!(
    first_name: "Churro", 
    last_name: "Chuong", 
    avatar_url: "https://happydogeface.com",
    occupation: "First Protector", 
    created_at: Date.new, 
    updated_at: Date.new)

  user2 = User.create!(
    first_name: "Mina", 
    last_name: "Chuong", 
    avatar_url: "https://happydogeface.com",
    occupation: "First Protector", 
    created_at: Date.new, 
    updated_at: Date.new)

  describe "GET /insights/summaries" do
    before :each do
      event_stubs = [
        {time: '2021-01-01', event_type: 'impression', revenue: 100, user_id: user1.id},
        {time: '2021-01-02', event_type: 'impression', revenue: 100, user_id: user1.id},
        {time: '2021-01-01', event_type: 'conversion', revenue: 300, user_id: user1.id},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300, user_id: user1.id}
      ]

      event_stubs.each do |event|
        MetricEvent.create!(
          time: event[:time], 
          user_id: event[:user_id],
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

  describe "GET /insights/dailyconversions" do
    before :each do
      event_stubs = [
        {time: '2021-01-01', event_type: 'conversion', revenue: 300, user_id: user1.id},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300, user_id: user1.id},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300, user_id: user1.id},
        {time: '2021-01-02', event_type: 'conversion', revenue: 300, user_id: user2.id}
      ]

      event_stubs.each do |event|
        MetricEvent.create!(
          time: event[:time], 
          user_id: event[:user_id],
          event_type: event[:event_type],
          revenue: event[:revenue],
          created_at: Date.new, 
          updated_at: Date.new)
      end
    end

    it "returns all daily conversions for all users" do
      get "/insights/dailyconversions"

      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body) 
      
      expect(parsed_response.length).to eq(2)
      actual_user_conversion = parsed_response[0]

      expect(actual_user_conversion["user_id"]).to eq(user1.id)
      expect(actual_user_conversion["conversions"].length).to eq(2)

      actual_daily_total1, actual_daily_total2 = actual_user_conversion["conversions"]
      expect(actual_daily_total1["date"]).to eq("2021-01-01T00:00:00.000Z")
      expect(actual_daily_total1["daily_conversions"]).to eq(1)

      expect(actual_daily_total2["date"]).to eq("2021-01-02T00:00:00.000Z")
      expect(actual_daily_total2["daily_conversions"]).to eq(2)
    end

    it "returns all daily conversions for specified user" do
      get "/insights/dailyconversions?userId=#{user1.id}"

      expect(response).to have_http_status(200)
      parsed_response = JSON.parse(response.body) 
      
      expect(parsed_response.length).to eq(1)
    end
  end
end
