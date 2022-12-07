require "rails_helper"

RSpec.describe Topic, :type => :model do
  it "is valid with valid attributes" do
    expect(Topic.new).to be_valid
  end
  #it "is not valid without a title"
  #it "is not valid without a content"
end
