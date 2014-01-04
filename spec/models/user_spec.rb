require 'spec_helper.rb'

describe User do
  let(:user) { build(:user) }

  describe "validations" do
    it "requires a name to be present" do
      user.name = nil

      user.save.should be_false
      user.errors[:name].any?.should be_true
    end

    it "requires a valid email address" do
      user.email = "asdf"

      user.save.should be_false
      user.errors[:email].any?.should be_true
    end
  end

  describe "password encryption" do
    it "encrypts the password before saving" do
      user.password_salt.should be_nil
      user.password_hash.should be_nil

      user.save

      user.password_salt.should_not be_nil
      user.password_salt.should_not be_empty

      user.password_hash.should_not be_nil
      user.password_hash.should_not be_empty
    end
  end

  describe "authentication" do

    it "authenticates with correct credentials" do
      user.save

      result = User.authenticate(user.email, user.password)

      result.should_not be_nil
      result.id.should eq(user.id)
    end

    it "fails authentication with bad credentials" do
      user.save

      result = User.authenticate(user.email, "badpassword")

      result.should be_nil
    end

  end

end
