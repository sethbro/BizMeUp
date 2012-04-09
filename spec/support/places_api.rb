MiniTest::Context.define 'places_api' do

  let :places_search_response do
  end

  let :place_summary_hash do
    { 'id'    => random_token,
      'name'  => 'Business As Usual',
      'ref'   => random_token,
      'geometry' => 'location' => {
        'lat' => '-87.4566',
        'lng' => '32.98190',
      },
      'vicinity' => '227 Eighties Reference St, Yesteryear, IL 60243',
      'rating' => '3.3',
      'icon'  => 'http://googleplaces/images/icon.png',
    }
  end

  let :place_info do
    {}
  end

end
