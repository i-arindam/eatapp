class SimpleSerializer < ActiveModel::Serializer
  def self.iso_timestamp_columns(cols)
    cols.each do |col|
      define_method col do
        timestamp_before_iso = object.send col
        timestamp_before_iso.iso8601
      end
    end
  end

  def read_attribute_for_serialization(attr)
    send(attr) rescue object.send(attr)
  end

  def id
    object.id.presence || SecureRandom.uuid
  end
end
