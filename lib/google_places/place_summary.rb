class GooglePlaces::PlaceSummary

  attr_reader :id, :ref, :name, :address, :latlng, :icon, :rating

  def initialize( data )
    @id       = data['id']
    @name     = data['name']
    @ref      = data['reference']
    @latlng   = latlng(data['geometry']['location'])
    @address  = data['vicinity']
    @rating   = data['rating']
    @icon     = data['icon']
  end


  private

  def latlng( loc_hash )
    '%s,%s' % [loc_hash['lat'], loc_hash['lng']]
  end

end
