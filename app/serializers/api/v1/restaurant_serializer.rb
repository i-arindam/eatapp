class Api::V1::RestaurantSerializer < SimpleSerializer
  attributes :id,
             :name,
             :address

  def address
    object.address.presence
  end
end
