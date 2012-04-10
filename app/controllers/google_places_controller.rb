class GooglePlacesController < ApplicationController

  layout false

  def search
  end

  def place
    begin
      @place = GooglePlaces::Client.get_place(params['ref'])
      @page[:title] = @place.name

      render
    rescue => e
      @page[:title] = @copy[:h1_error]
      @errors = @copy[:place_error]
    end
  end

end
