class HomeController < ApplicationController

  DEFAULT_LOCATION = '41.9,-87.67'
  DEFAULT_TYPES = 'restaurant|bar'

  def index
    loc = params[:latlng] || DEFAULT_LOCATION
    types = DEFAULT_TYPES

    raw_place_results = GooglePlaces::Client.search(loc, {types: types})
    place_results = (raw_place_results) ? raw_place_results['results'] : []
    #place_results = GooglePlaces::Client.shill_data

    @nearby_places = []
    unless place_results.blank?
      @nearby_places = place_results.map { |place| GooglePlaces::PlaceSummary.new(place) }.shift 8
    end
  end


  private

end
