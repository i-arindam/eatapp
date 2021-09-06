class Api::V1::ReservationSerializer < SimpleSerializer
  iso_timestamp_columns %i[created_at updated_at start_time]

  attributes :id,
             :status,
             :covers,
             :walk_in,
             :start_time,
             :duration,
             :notes,
             :created_at,
             :updated_at

  belongs_to :restaurant, serializer: Api::V1::RestaurantSerializer
  has_one    :guest,      serializer: Api::V1::GuestSerializer
  has_many   :tables,     serializer: Api::V1::TableSerializer

  def notes
    object.notes.presence
  end
end
