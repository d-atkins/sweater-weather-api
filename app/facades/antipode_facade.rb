class AntipodeFacade

  def initialize(location)
    @location = location
    # require "pry"; binding.pry
  end

  def location_name

  end

  def forecast

  end

  private

    def origin_coordinates
      @origin_coordinates ||= GeocodeService.get_coordinates(@location)[:geometry][:location]
    end

    def antipode_coordinates
      @antipode_coordinates ||= AntipodeService.get_antipode_coordinates(origin_coordinates[:lat], origin_coordinates[:lng])[:attributes]
    end
end
