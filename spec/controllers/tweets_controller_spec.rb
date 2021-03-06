require 'rails_helper'
require 'webmock/rspec'

describe TweetsController do
  before do
    stub_request(:get, "http://tweeps.locaweb.com.br/").
      with(headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host' => 'tweeps.locaweb.com.br',
        'User-Agent' => 'Ruby',
        'Username' => 'eoliveiramg@gmail.com'
      }).to_return(status: 200, body: "locaweb")
    
  end

  context "on index" do
    it "render the index" do
      allow_any_instance_of(TweetsController).to receive(:index).and_return(true)
      get :index

      expect(response).to be_success
    end

    it "returns expected body" do
      allow_any_instance_of(TweetsController).to receive(:parsed_tweets).and_return('locaweb')
      allow_any_instance_of(TweetBusinessRules).to receive(:filter).and_return('locaweb')
      allow_any_instance_of(TweetBusinessRules).to receive(:sort).and_return('locaweb')
      
      get :index

      expect(response.body).to eq('')
    end
  end
end
