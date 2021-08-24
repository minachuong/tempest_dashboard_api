class InsightsController < ApplicationController
  def index
    insightsService = InsightsService.new
    render :json => insightsService.select_insights
  end

  def daily_conversions_by_user_id 
    insightsService = InsightsService.new
    # TODO: whitelist params here?
    render :json => insightsService.select_daily_conversions_by_user_id(params[:user_id])
  end

end
