class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    api_key = "b80e958596cc0da9c1ec7ff18bc106aa"
    url = "http://beermapping.com/webservice/locquery/#{api_key}/"
    response = HTTParty.get "#{url}#{params[:id]}"
    place = Place.new(response.parsed_response["bmp_locations"]["location"])

    if place.is_a?(Hash) and place['id'].nil?
      redirect_to places_path, :notice => "Not found"
    else
      @place = place
      end
    end
  end
