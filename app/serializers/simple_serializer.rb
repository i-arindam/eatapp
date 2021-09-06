class SimpleSerializer < ActiveModel::Serializer
  def self.iso_timestamp_columns(*cols)

  end

  def read_attribute_for_serialization(attr)
    send(attr) rescue object.send(attr)
  end

  def id
    object.id.presence || SecureRandom.uuid
  end
end
