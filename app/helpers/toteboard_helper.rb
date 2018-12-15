module ToteboardHelper
  def race_day_list_collection
    @races.map do |v|
      {
        :title => v["Date"],
        :link => toteboard_race_day_path(:race_count => v["NumRaces"], :race_day => v["Date"])
      }
    end
  end

  def race_list_collection
    (1..@race_count.to_i).map do |v|
      {
        :title => v,
        :link => toteboard_race_day_path(
          :race_count => @race_count,
          :race_day => @race_day,
          :race_num => v
        ),
      }
    end
  end
end
