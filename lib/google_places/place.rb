class GooglePlaces::Place

  attr_accessor :address_1, :address_2, :state, :city, :zip, :country,
    :street_number, :name, :lat, :lng, :latlng, :address, :phone,
    :url, :types, :icon, :vicinity, :rating, :reference

  def initialize( attrs )
    @name = attrs['name']
    @phone = attrs['formatted_phone_number']
    @address = attrs['formatted_address']

    map_address_components( attrs['address_components'] )
    set_lat_lng( attrs['geometry']['location'] )
    set_addtl_info( attrs )
  end


  private

  @attr_map = {
    street_number:  'street_number',
    street_name:    'route',
    city:           'locality',
    state:          'administrative_area_level_1',
    zip:            'postal_code',
    postal_code:    'postal_code',
    country:        'country',
  }

  class << self
    attr_accessor :attr_map
  end

  def map_address_components( address_components )
    mappable_attrs = GooglePlaces::Place.attr_map.keys.map(&:to_s)

    address_components.each do |component_hash|
      name = component_hash['types'][0]
      next unless mappable_attrs.include? name

      val = component_hash['long_name']
      self.send( "#{self.class.attr_map.key(name)}=", val )
    end

    @address_1 = [@street_number, @street_name].join ' '
  end

  def set_lat_lng( loc )
    @lat = loc['lat']
    @lng = loc['lng']
    @latlng = [@lat, @lng].join( ',' )
  end

  def set_addtl_info( attrs )
    %w(url reference vicinity rating types icon).each do |attr|
      self.send( "#{attr}=", attrs[attr] )
    end
  end

end
