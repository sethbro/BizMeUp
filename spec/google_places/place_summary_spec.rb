require 'spec_helper'

describe GooglePlaces::PlaceSummary do
  inherit_context 'places_api'

  it 'sets attributes based on passed data hash' do
    place = GooglePlaces::PlaceSummary.new(place_summary_hash)
    place.id.must_equal place_summary_hash['id']
    place.name.must_equal place_summary_hash['name']
    # ...
  end

end
