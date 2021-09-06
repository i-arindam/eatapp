Reservation = Struct.new(:id, :status, :covers, :walk_in, :start_time, :duration, :notes, :guest, :restaurant, :tables) do
  def id
    @id.presence || SecureRandom.uuid
  end

  def created_at
    Time.current
  end

  def updated_at
    Time.current
  end
end
