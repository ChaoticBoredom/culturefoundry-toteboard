class ToteboardController < ApplicationController
  def index
    @races = HTTParty.
      get("#{Rails.configuration.x.api_prefix}/race-days.json").
      parsed_response.
      sort_by { |v| v["Date"] }
  end

  def race_day
    @race_day = params.fetch(:race_day)
    @race_count = params.fetch(:race_count)
    race_num = params.fetch(:race_num, 1)
    @race = HTTParty.
      get("#{Rails.configuration.x.api_prefix}/race-days/#{@race_day}/races/#{race_num}.json").
      parsed_response

    respond_to :js
  end
end
