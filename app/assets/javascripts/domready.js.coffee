$.jQTouch({
    icon: 'jqtouch.png',
    statusBar: 'black-translucent',
    preloadImages: []
});

Zepto( ($) ->
  BMU.bindPageEvents()
)


root = global ? window
