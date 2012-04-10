describe GooglePlacesController do

  let(:ref) { 'xyz123' }
  let(:place_attrs) do
    { 'name' => 'Placeopolis',
      'formatted_phone_number' => '123',
      'vicinity' => '123 Street',
      'geometry' => {'location' => {'lat' => '87.92', 'lng' => '42.23'}},
      'website' => 'http://wtf.co'
    }
  end

  let(:place) { GooglePlaces::Place.new(place_attrs).stubs(place_attrs) }

  it 'calls google client with reference #' do
    GooglePlaces::Client.expects(:get_place)
    get :place, ref: ref
  end

  it 'instantiates a google place' do
    GooglePlaces::Client.expects(:get_place).returns(place)
    get :place, ref: ref

    assigns[:place].must_equal place
  end

  it 'fails gracefully on bad network call' do
    GooglePlaces::Client.stubs(:get_place).throws(:http_error)
    get :place, ref: ref
    
    assigns[:errors].wont_be_nil
  end

end
