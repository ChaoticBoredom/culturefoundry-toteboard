class ToteboardController < ApplicationController
  API_PREFIX = "http://interview.dev.cfdv.net/tracks/CD".freeze

  def index
    @races = HTTParty.
      get("#{API_PREFIX}/race-days.json").
      parsed_response.
      sort_by { |v| v["Date"] }
  end

  def race_day
    @race = HTTParty.
      get("#{API_PREFIX}/race-days/#{params[:race_day]}/races/#{params[:race_num]}.json").
      parsed_response

    respond_to :js
  end
end
