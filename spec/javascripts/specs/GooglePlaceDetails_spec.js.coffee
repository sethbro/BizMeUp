require('/assets/env.js.coffee')
require('/assets/class/GooglePlaceDetails.js.coffee')

describe 'GooglePlaceDetails', ->
  root = global ? window

  template 'google_place_details.html'

  beforeEach ->
    root.$place = $('#place')
    #root.place = new BMU.GooglePlaceDetails($place)

  it 'makes an api call with place reference token', ->
    spyOn($, 'ajax')
    root.place = new BMU.GooglePlaceDetails($place)

    expect($.ajax).toHaveBeenCalledWith($place)

  it 'collects place details as a markup string', ->

  it 'falls back to error message string on failure', ->
    error_response = {}
    spyOn($, 'ajax').andReturn(error_response)
    spyOn(place, 'callError').andCallThrough()

    expect(place.callError).toHaveBeenCalled()
    expect(place.markup) == place.errorMessage
