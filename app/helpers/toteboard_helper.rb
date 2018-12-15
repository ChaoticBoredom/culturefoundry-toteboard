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

  def horse_placed(place)
    @race.fetch("Entries", []).select { |x| x["FinishPosition"] == place }.first
  end

  def also_ran_horses
    @race.
      fetch("Entries", []).
      select { |x| also_ran(x) }
  end

  def scratched_horses
    @race.
      fetch("Entries", []).
      select { |x| scratched(x) }
  end

  def horse_display(entry)
    horse_number = entry.dig("ProgramNumber")
    horse_name = entry.dig("Horse", "Name")
    "#{horse_number} - #{horse_name}"
  end

  private

  def scratched(entry)
    entry.fetch("Scratched", false)
  end

  def also_ran(entry)
    return false if scratched(entry)

    return false if [1, 2, 3].include?(entry.fetch("FinishPosition", 0))

    true
  end
end
