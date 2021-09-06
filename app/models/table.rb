Table = Struct.new(:id, :number, :max_covers) do
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
