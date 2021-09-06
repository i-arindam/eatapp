class Api::V1::GuestSerializer < SimpleSerializer
  attributes :id,
             :first_name,
             :last_name
end
