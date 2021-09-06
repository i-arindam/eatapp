Restaurant = Struct.new(:id, :name, :address) do
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
