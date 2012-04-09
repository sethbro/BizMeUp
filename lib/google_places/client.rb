require 'httparty'

class GooglePlaces::Client
  include HTTParty

  URL = 'https://maps.googleapis.com/maps/api/place'
  KEY = ENV['GOOGLE_PLACES_API_KEY'] || 'AIzaSyBY6gNvmizZkYxOSWhybpv4ja4voo9NNIA'
  BAD_RESPONSES = %w(REQUEST_DENIED UNKNOWN_ERROR)

  @format = :json
  @sensor = false
  @defaults = {
    key: KEY,
    radius: 2000,
    sensor: @sensor,
  }


  class << self
    attr_accessor :format, :sensor, :defaults

    def places_url(action)
      [ URL, action.to_s, @format.to_s ].join '/'
    end

    def search( latlng, parameters={} )
      required = { location: latlng }
      params = @defaults.merge( parameters ).merge( required )

      Rails.logger.info "Searching for Google Place in latlng #{latlng}"

      response = api_call( places_url( 'search' ), params )
    end

    def get_place( ref )
      response = details( ref )
      attrs = response['result']

      GooglePlaces::Place.new( attrs )
    end

    def details( ref, parameters={} )
      required = { reference: ref }
      params = @defaults.merge( parameters ).merge( required )

      response = api_call(places_url(:details), params)
    end

    def best_guess( places, info )
      places = sort_by_type(places, info) if info.has_key? 'type'
      places = sort_by_latlng(places, info) if info.has_key?('lat') && info.has_key?('lng')
      places = sort_by_name(places) if info.has_key? 'name'

      Rails.logger.info "Best Guess is #{places.first['name']} - #{places.first['vicinity']}"

      places.first
    end

    # No internet access requires other solutions
    def shill_data(num=8)
      (1..num).map do |i|
        data_hash = {id: i, reference: "#{i}XYZ", name: company_name, vicinity: rand_address, rating: rand(4) + 1, icon: rand_icon, 'geometry' => { 'location' => rand_latlng }}
      end
    end

    def company_name
      names = %w(Totally Incredible Salacious Domineering Glinting Terrarium Gypsum)
      names_2 = %w(Whatever Gerbils Gravitas Itineraries Believers Ignorance)
      suffixes = %w(Inc. LLC Co)
      co = names[rand(names.length)]
      co << ' ' << get_rand(names_2)
      co << ' ' << get_rand(suffixes) if rand(1) == 0
    end

    def rand_address
      streets = %w(Main Michigan Caribou Pathology Direct Juniper)
      road_types = %w(St Blvd Ave)
      num = (rand(9998) + 1).to_s
      '%s %s %s' % [num, get_rand(streets), get_rand(road_types)]
    end

    def rand_icon
      '/assets/icon_rest.png'
    end

    def rand_latlng
      '-87.24234,32.20934'
    end

    def get_rand(arr)
      arr[rand(arr.length)]
    end
  end


  private

  class << self

    def api_call(url, params, verb = :get)
      begin
        if verb == :get
          response = get(url, query: params)
        elsif verb == :post
          response = post(url, body: params)
        end
      rescue => e
      end
    end

    def sort_by_name(places, info=nil)
      places.reject { |place| place['name'].casecmp( info['name'] ) != 0 }
    end

    def sort_by_type(places, info=nil)
      places.sort do |place|
        est = place['types'].include? 'establishment'
        est ? 1 : -1
      end
    end

    def sort_by_latlng( places, info )
      places.sort do |place|
        geo = place['geometry']

        lat_match = coords_match?(geo['latitude'], info[:lat])
        lng_match = coords_match?(geo['longitude'], info[:lat])
        return 1 if lat_match && lng_match
        lat_match || lng_match ? 1 : -1
      end
    end

    def coords_match?(coord1, coord2, to_nth=6)
      coord1.to_f.round(to_nth) == coord2.to_f.round(to_nth)
    end
  end

end
