require 'httparty'

module GooglePlaces
  class Client
    include Singleton
    include HTTParty

    # TODO: Move to env vars
    URL = 'https://maps.googleapis.com/maps/api/place'
    KEY = 'AIzaSyBY6gNvmizZkYxOSWhybpv4ja4voo9NNIA'
    BAD_RESPONSES = %w(REQUEST_DENIED UNKNOWN_ERROR)

    @format = :json
    @sensor = false

    @defaults = {
      'key' => KEY,
      'radius' => 2000,
      'sensor' => @sensor
    }

    class << self

      def get_place( ref )
        response = details( ref )
        attrs = response['result']

        GooglePlaces::Place.new( attrs )
      end

      def search( name, latlng, parameters={} )
        required = { 'name' => name, 'location' => latlng }
        params = @defaults.merge( parameters ).merge( required )

        Rails.logger.debug "Searching for Google Place w/name #{name}, latlng #{latlng}"
        response = get_request( places_url( 'search' ), params )
      end

      def details( ref, parameters={} )
        required = { 'reference' => ref }
        params = @defaults.merge( parameters ).merge( required )

        response = get_request( places_url( 'details' ), params )
      end

      def best_guess( places, info )
        places = sort_by_type(places, info) if info.has_key? 'type'
        places = sort_by_latlng( places, info ) if info.has_key?( 'lat' ) && info.has_key?( 'lng' )
        places = sort_by_name( places ) if info.has_key? 'name'

        Rails.logger.debug "Best Guess is #{places.first['name']} - #{places.first['vicinity']}"
        places.first
      end
    end


    private

    class << self

      def places_url( action )
        [ URL, action, @format ].join '/'
      end

      def get_request( url, params )
        begin
          response = get( url, query: params )
          #BAD_RESPONSES.include? response['status'] ? nil : response
        rescue => e
        end
      end

      def sort_by_name( places, info=nil )
        places.reject {|place| place['name'].casecmp( info['name'] ) != 0 }
      end

      def sort_by_type( places, info=nil )
        places.sort do |place|
          est = place['types'].include? 'establishment'
          est ? 1 : -1
        end
      end

      def sort_by_latlng( places, info )
        places.sort do |place|
          geo = place['geometry']
          lat_match = geo['latitude'].to_f.round( 6 ) == info[:lat].to_f.round( 6 )
          lng_match = geo['longitude'].to_f.round( 6 ) == info[:lng].to_f.round( 6 )
          return 1 if lat_match && lng_match
          #lng_match ? 1 : -1
          lat_match ? 1 : -1
        end
      end

    end

  end
end
