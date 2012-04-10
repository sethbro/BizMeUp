require('/assets/class/GooglePlaceDetails.js.coffee')

describe 'GooglePlaceDetails', ->
  root = global ? window

  template 'google_place_details.html'

  beforeEach ->
    root.$place = $('#place1')

  it 'makes an api call with place reference token', ->
    spyOn($, 'ajax')
    place = new BMU.GooglePlaceDetails($place)

    expect($.ajax).toHaveBeenCalled()

  it 'falls back to error message string on failure', ->
    error_response = {status: 500}

    spyOn($, 'ajax').andReturn(error_response)
    place = new BMU.GooglePlaceDetails($place)

    expect(place.markup) == place.errorMessage()

  it 'inserts response into place div', ->
    result = '<div>RESULT</div>'
    spyOn($, 'ajax').andReturn(result)

    place = new BMU.GooglePlaceDetails($place)
    $content = $("#place_details #{place.css.content}")
    expect($content.html()) == result
