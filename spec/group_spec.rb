require 'spec_helper'

describe Meetup::Group do

  subject { Meetup::Group.new(Meetup::Client.new(:api_key => meetup_api_key)) }

  it "should find a group by an id" do
    id = 12345
    stub_request(:get, meetup_url(Meetup::Group::PATH)).with(:query => { :id => id.to_s, :key => meetup_api_key }).to_return(:body => fixture_file('group.json'), :status => 200)
    group = subject.by_id id
    group.name.should == 'Toronto Ruby Brigade'
    group.organizer_name.should == 'Kevin Faustino'
    group.link.should == 'http://www.meetup.com/torontoruby/'
  end

end
