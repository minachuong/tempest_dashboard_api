class InsightsController < ApplicationController
  def index
    insightsService = InsightsService.new
    render :json => insightsService.select_insights
  end

  def get_daily_conversions 
    insightsService = InsightsService.new
    # TODO: whitelist params here?
    user_id = params[:userId]
    render :json => insightsService.select_daily_conversions(params[:userId])
  end
end
