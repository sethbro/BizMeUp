class GooglePlaceDetails

  constructor: (host_elem) ->
    @$el = $(host_elem)
    @markup = @errorMessage()
    @getPlaceInfo(@$el.data('ref'))

  css:
    content: '.content'

  getPlaceInfo: (ref) ->
    #@resetPageContent()
    options =
      url: "/google_places/place"
      data: {ref: ref}
      dataType: 'html'
      complete: _.bind((xhr, status) ->
        if xhr.status == 200 || xhr.status == 304
          @callSuccess(xhr, status)
        else
          @callError(xhr)
      , @)

    $.ajax(options)

  callSuccess: (xhr, status) ->
    @markup = xhr.responseText
    @$el.find(@css.content).html(@markup)

  callError: (xhr, errorType, error) ->
    @markup = @errorMessage()
    @$el.find(@css.content).html(@markup)

  resetPageContent: () ->
    @$el.find(@css.content).html('')

  # TODO: Derive from Rails locales
  errorMessage: ->
    'There was a problem retrieving information for this place.'


root = global ? window
root.BMU.GooglePlaceDetails = GooglePlaceDetails
