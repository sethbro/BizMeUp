require 'spec_helper'

describe HomeController do
  inherit_context 'places_api'

  it 'contacts Google places api' do
    GooglePlaces::Client.expects(:search)

    get :index
  end

  it 'sets an array of place data' do
    get :index
    assigns[:nearby_places].must_respond_to :[]
  end

  it 'provides a default location if none is found' do
  end

  it 'does not throw an error on blank or nil result' do
  end

end
