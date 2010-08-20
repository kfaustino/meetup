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

  it "should limit results by a geolocation" do
    stub_request(:get, meetup_url(Meetup::Group::PATH)).with( :query => { :country => 'CA',
                                                                          :city => 'Toronto',
                                                                          :state => 'ON',
                                                                          :page => '20',
                                                                          :radius => '5.0',
                                                                          :key => meetup_api_key}).to_return(:body => fixture_file('groups.json'), :status => 200)

    groups = subject.geolocation('CA','Toronto','ON').radius(5.0).limit(20).fetch
    groups.should have(20).items

    groups.each do |group|
      group.state.should == 'ON'
      group.country.should == 'ca'
      ['Toronto', 'North York'].should include(group.city)
    end
  end

  it "should filter by a member" do
    member_id = '1'
    options = {:query => { :member_id => member_id, :key => meetup_api_key }}
    request_uri = meetup_url Meetup::Group::PATH
    stub_request(:get, request_uri).with(options).to_return(:body => fixture_file('groups.json'))
    
    subject.by_member(member_id).fetch
    request(:get, request_uri).with(options).should have_been_made
  end

end
