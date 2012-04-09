MiniTest::Context.define 'places_api' do

  let :places_search_response do
  end

  let :place_summary_hash do
    { 'id'    => 'x0u8ux0u',
      'name'  => 'Business As Usual',
      'ref'   => 'xx8uokjkadjs2rur',
      'geometry' => {'location' => {
        'lat' => '-87.4566',
        'lng' => '32.98190',
      }},
      'vicinity' => '227 Eighties Reference St, Yesteryear, IL 60243',
      'icon'  => 'http://googleplaces/images/icon.png',
      'rating' => '3.3',
    }
  end

  let :place_info do
    {}
  end

end
