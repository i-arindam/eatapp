class SimpleSerializer < ActiveModel::Serializer
  class << self
    def iso_timestamp_columns(cols)
      cols.each do |col|
        # @returns getter method with the name +col+
        #   Used to define methods on the serializer as overrides to the object's getter methods with
        #   iso converted times
        define_method col do
          timestamp_before_iso = object.send col
          timestamp_before_iso.iso8601
        end
      end
    end
  end

  # For non active record objects that need to be serialized, this method needs to be defined
  # Usually, calling the attr on the serializer's object is enough to setup the method relay,
  # but in this case, we have few methods defined on the serializer to obtain the iso time values.
  # Therefore, calling the method first on the serializer is required to get those values.
  # For every other attribute that's defined on the object, we send the attr call back to the object.
  def read_attribute_for_serialization(attr)
    send(attr) rescue object.send(attr)
  end
end
