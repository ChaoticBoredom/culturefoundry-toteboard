class ToteboardController < ApplicationController
  def index
    @race_days = HTTParty.get("http://interview.dev.cfdv.net/tracks/CD/race-days.json")
  end
end
