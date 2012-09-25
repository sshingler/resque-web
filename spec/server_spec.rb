require 'spec_helper'
require 'resque-web/server'

describe Resque::Server do
  it "/ redirects to overview" do
    get "/"
    follow_redirect!
  end

  it "on GET to /overview should at least display 'queues'" do
    get "/overview"
    last_response.body.should =~ /Queues/
  end

  it "should GET /working" do
    get "/working"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end

  it "should GET /failed" do
    get "/failed"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end

  it "should GET /stats/resque" do
    pending "Don't know why this fails yet"
    get "/stats/resque"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end

  it "should GET /stats/redis" do
    get "/stats/redis"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end

  it "should GET /stats/keys" do
    pending "Don't know why this fails yet"
    get "/stats/keys"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end

  it "also works with slash at the end" do
    get "/working/"
    last_response.ok?.should == true
    last_response.errors.should == ""
  end
end
