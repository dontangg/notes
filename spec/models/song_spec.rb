require 'spec_helper'

describe Song do
  let(:song) { build(:song) } 

  describe "validations" do
    it "requires that song is not empty" do
      song.name = nil

      song.save.should be_false
      song.errors[:name].any?.should be_true
    end

    it "requires that artist is not empty" do
      song.artist = nil

      song.save.should be_false
      song.errors[:artist].any?.should be_true
    end
  end

  describe "song creation" do
    it "verifies that songs can be successfully added" do
      song.name.should_not be_empty
      song.artist.should_not be_empty
      song.save

      song.save.should be_true
      song.errors[:artist].any?.should be_false
      song.errors[:name].any?.should be_false
    end
  end
end
