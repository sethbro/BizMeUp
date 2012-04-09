require_relative '../spec_helper'

describe GooglePlaces::Client do

  let(:name)      { 'Business As Usual' }
  let(:latlng)    { '0.0,0.0' }
  let(:place_ref) { 'x0a1' }
  let(:details_url) { [GooglePlaces::Client::URL, 'details', 'json'].join '/' }
  let :details_params do
    { reference: place_ref }.merge(GooglePlaces::Client.defaults)
  end


  describe 'network' do
    before do
      #GooglePlaces::Client.stubs :get
      #GooglePlaces::Client.stubs :post
    end

    it 'derives url from action and format' do
      GooglePlaces::Client.places_url('details').must_equal details_url
    end

    it 'makes a get request with query arg by default' do
      GooglePlaces::Client.expects(:get).with(details_url, query: details_params)

      GooglePlaces::Client.details(place_ref)
    end

    it 'makes a post request with body arg' do
      skip 'No post methods yet'
      GooglePlaces::Client.expects(:post).with(details_url, body: details_params)

      GooglePlaces::Client.details(place_ref)
    end
  end

end
