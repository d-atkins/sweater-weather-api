class Background
  attr_reader :id, :url_l, :url_o, :title
  def initialize(image_info)
    @title = image_info[:title]
    @url_l = image_info[:url_l]
    @url_o = image_info[:url_o]
  end
end
