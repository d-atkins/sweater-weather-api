class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url_o, :url_l, :title
end
