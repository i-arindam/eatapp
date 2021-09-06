# Guest = Struct.new(:id, :first_name, :last_name) do
#   def id
#     self['id'].presence || SecureRandom.uuid
#   end

#   def created_at
#     Time.current
#   end

#   def updated_at
#     Time.current
#   end
# end



# BaseStruct = -> (*attrs) do
#   Struct.new(*attrs) do
#     def id
#       self['id'].presence || SecureRandom.uuid
#     end

#     def created_at
#       Time.current
#     end

#     def updated_at
#       Time.current
#     end
#   end
# end

Guest = BaseStructWithOverridenIdAndTimeValues.call(
  :id,
  :first_name,
  :last_name
)
