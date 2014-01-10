require 'spec_helper'

describe Submission do
  let(:submission) { build(:submission) } 

  describe "validations" do
    it "requires that song is not empty" do
      submission.song = nil

      submission.save.should be_false
      submission.errors[:song].any?.should be_true
    end

    it "requires that artist is not empty" do
      submission.artist = nil

      submission.save.should be_false
      submission.errors[:artist].any?.should be_true
    end
  end

  describe "submission creation" do
    it "verifies that songs can be successfully added" do
      submission.song.should_not be_empty
      submission.artist.should_not be_empty
      submission.save

      submission.save.should be_true
      submission.errors[:artist].any?.should be_false
      submission.errors[:song].any?.should be_false
    end
  end
end
