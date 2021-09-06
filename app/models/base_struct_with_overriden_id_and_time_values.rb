# This is a struct factory, which will create a new struct with the required attributes.
#
# @params <attrs> - Array of attributes for the model
# @returns
#   Returns a struct with the provided attributes as its members.
#   The returned struct becomes the value of the caller
BaseStructWithOverridenIdAndTimeValues = -> (*attrs) do
  Struct.new(*attrs) do
    def id
      self['id'].presence || SecureRandom.uuid
    end

    def created_at
      Time.current
    end

    def updated_at
      Time.current
    end
  end
end
