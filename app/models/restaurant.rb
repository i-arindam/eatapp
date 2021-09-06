Restaurant = Struct.new(:id, :name, :address) do
  def created_at
    Time.current
  end

  def updated_at
    Time.current
  end
end
