module Jsonable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
