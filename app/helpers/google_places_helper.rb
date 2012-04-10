module GooglePlacesHelper

  def static_google_map( latlng, marker_latlng = nil )
    base_url = "http://maps.googleapis.com/maps/api/staticmap?"
    params = {
      'center' => latlng,
      'size'   => '120x120',
      'zoom'   => '14',
      'sensor' => 'false',
    }
    params['markers'] = "|#{marker_latlng}" if marker_latlng
    src = base_url << params.map { |k,v| "#{k}=#{v}" }.join('&')
    image_tag(src, class: 'google_map')
  end

  def star_rating(rating, max = 5)
    rating = rating.round
    empty = max - rating

    markup = ''
    rating.times.each { markup += image_tag '/assets/star_fav.png' }
    empty.times.each { markup += image_tag '/assets/star_fav_empty.png' }

    raw markup
  end

end
