BMU =
  css:
    placeDetailsPage: '#place_details'

  bindPageEvents: ->
    $('.place').tap( (evt) ->
      if evt.currentTarget.tagName == 'LI'
        ref = $(evt.currentTarget).data('ref')
        $(BMU.css.placeDetailsPage).data('ref', ref)
    )

    $(BMU.css.placeDetailsPage).bind('pageAnimationEnd', (evt, info) ->
      console.log 'animate', evt, info
      return if info.direction == 'out'
      BMU.currentPlace = new BMU.GooglePlaceDetails(evt.target)
    )


root = global ? window
root.BMU = BMU
