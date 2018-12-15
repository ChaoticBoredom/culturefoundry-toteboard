require "rails_helper"

RSpec.describe ToteboardHelper, :type => :helper do
  let(:race) { { "Entries" => [first_place_horse, scratched_horse, also_ran_horse] } }

  let(:first_place_horse) do
    {
      "ProgramNumber" => "1",
      "PostPosition" => 1,
      "Scratched" => false,
      "Horse" => { "Name" => "Horsey McHorseFace" },
      "FinishPosition" => 1,
      "WinPayoff" => 15.0,
      "PlacePayoff" => 10.0,
      "ShowPayoff" => 5.0,
    }
  end

  let(:scratched_horse) do
    {
      "ProgramNumber" => "2",
      "PostPosition" => 2,
      "Scratched" => true,
      "Horse" => { "Name" => "Good Guy Greg" },
    }
  end

  let(:also_ran_horse) do
    {
      "ProgramNumber" => "3",
      "PostPosition" => 3,
      "Scratched" => false,
      "Horse" => { "Name" => "Scumbag Steve" },
      "FinishPosition" => 4,
    }
  end

  let(:error_horse) { { "Horse" => { "Name" => "I am ERROR" } } }

  before(:each) do
    instance_variable_set(:@race, race)
  end

  describe "#race_day_list_collection" do
    let(:races) do
      [
        { "Date" => "2018-12-14", "NumRaces" => "10" },
        { "Date" => "2017-11-11", "NumRaces" => "11" },
        { "Date" => "2018-04-30" },
      ]
    end

    before(:each) do
      instance_variable_set(:@races, races)
    end

    it "should return an array" do
      expect(race_day_list_collection).to be_an Array
    end

    it "should set the title to be the date" do
      collection = race_day_list_collection
      collection.each do |obj|
        expect(obj[:title]).to match(/\d{4}-\d{2}-\d{2}/)
      end
    end
  end

  describe "#race_list_collection" do
    let(:race_count) { "5" }

    before(:each) do
      instance_variable_set(:@race_count, race_count)
    end

    it "should return an array" do
      expect(race_list_collection).to be_an Array
    end

    it "should have the same number of entries as the count" do
      expect(race_list_collection.size).to eq race_count.to_i
    end
  end

  describe "#horse_placed" do
    it "should return the horse that finished in given place" do
      expect(horse_placed(1)).to eq first_place_horse
    end
  end

  describe "#also_ran_horses" do
    it "should return also ran horses" do
      expect(also_ran_horses).to include also_ran_horse
    end

    it "should not return scratched horses" do
      expect(also_ran_horses).to_not include scratched_horse
    end

    it "should not return horses that placed" do
      expect(also_ran_horses).to_not include first_place_horse
    end
  end

  describe "#scratched_horses" do
    it "should return scratched horses" do
      expect(scratched_horses).to include scratched_horse
    end

    it "should not return horses that ran" do
      expect(scratched_horses).to_not include(also_ran_horse, first_place_horse)
    end
  end

  describe "#horse_display" do
    it "should return the horse name formatted" do
      expect(horse_display(first_place_horse)).to eq "1 - Horsey McHorseFace"
    end

    context "when given bad input" do
      it "should not throw an error" do
        expect { horse_display(error_horse) }.to_not raise_error
      end
    end
  end
end
