require 'spec_helper'

describe Meetup do

  context "configuration" do
    
    it "should set the api_key" do
      api_key = 'meetup-key'
      Meetup.configure {|config| config.api_key = api_key }
      client = Meetup::Client.new
      client.api_key.should == api_key
    end
    
  end

end
