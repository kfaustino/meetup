require 'spec_helper'

describe Faraday::Response::Errors do

  context "when used" do

    before(:each) do
      @url_path = '/some_url'
    end
    
    context "400 response code" do

      it "should throw a General error" do
        connection = create_connection 400, fixture_file('400.json')
        lambda { connection.get @url_path }.should raise_error(Meetup::GeneralError)
      end

    end

    context "401 response code" do

      it "should throw an Unauthorized error" do
        connection = create_connection 401, fixture_file('401.json')
        lambda { connection.get @url_path }.should raise_error(Meetup::UnauthorizedError)
      end

    end
    
    context "500 response code" do
      
      it "should throw a Server error" do
        connection = create_connection 500, ''
        lambda { connection.get @url_path }.should raise_error(Meetup::ServerError)
      end
      
    end

  end

  def create_connection(status, body)
    Faraday::Connection.new do |builder|
      builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get(@url_path) { [status, {}, body ] }
      end
      builder.use Faraday::Response::MultiJson
      builder.use Faraday::Response::Errors
    end
  end

end
