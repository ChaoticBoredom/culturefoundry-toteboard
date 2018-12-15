class ToteboardController < ApplicationController
  def index
    @races = HTTParty.
      get("#{Rails.configuration.x.api_prefix}/race-days.json").
      parsed_response.
      sort_by { |v| v["Date"] }
    set_race_day(@races.first["Date"], 1)
    @race_count = @races.first["NumRaces"]
  end

  def race_day
    set_race_day(params.fetch(:race_day), params.fetch(:race_num, 1))
    @race_count = params.fetch(:race_count)

    respond_to :js
  end

  private

  def set_race_day(day, race_num)
    @race_day = day
    @race = HTTParty.
      get("#{Rails.configuration.x.api_prefix}/race-days/#{@race_day}/races/#{race_num}.json").
      parsed_response
  end
end
