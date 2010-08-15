require 'spec_helper'

describe Faraday::Response::UTFEncoder do

  before(:each) do
    @path = '/some_url'
    @json = fixture_file 'groups.json'
  end

  context "when used" do

    it "should convert ISO-8859-1 responses to UTF-8" do
      connection = Faraday::Connection.new do |builder|
        builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stubs|
          stubs.get(@path) { [ 200, {}, @json] }
        end
        builder.use Faraday::Response::UTFEncoder
        builder.use Faraday::Response::MultiJson
      end

      lambda { connection.get(@path) }.should_not raise_error
    end

  end

  context "not used" do

    it "should raise a UTF-8 parsing error" do
      connection = Faraday::Connection.new do |builder|
        builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stubs|
          stubs.get(@path) { [ 200, {}, @json] }
        end
        builder.use Faraday::Response::MultiJson
      end

      lambda { connection.get(@path) }.should raise_error
    end

  end

end
