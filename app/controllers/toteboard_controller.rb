class ToteboardController < ApplicationController
  def index
    @races = HTTParty.get("http://interview.dev.cfdv.net/tracks/CD/race-days.json")
  end
end
