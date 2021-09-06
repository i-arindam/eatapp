# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ReservationSerializer do
  subject { serializer.as_json.deep_stringify_keys }

  let(:reservation) do
    Reservation.new(
      "RE100",
      "not_confirmed",
      2,
      false,
      10.days.ago,
      5400,
      nil,
      guest,
      restaurant,
      tables,
    )
  end
  let(:serializer)  { Api::V1::ReservationSerializer.new(reservation) }
  let(:guest) { Guest.new("G100", "John", "Doe") }
  let(:restaurant) { Restaurant.new("R100", "This Resto", "That Street, Which City") }
  let(:tables) do
    2.times.map do |i|
      i += 1
      Table.new("Table#{i}", 10*i, 20*i)
    end
  end

  it "allows attributes to be defined for serialization" do
    expect(subject.keys).to contain_exactly(
      *%w(
        id
        status
        covers
        walk_in
        start_time
        duration
        notes
        created_at
        updated_at
        restaurant
        guest
        tables
      )
    )
  end

  describe "relationships" do
    it "returns single restaurant" do
      data = Api::V1::RestaurantSerializer.new(restaurant).as_json.deep_stringify_keys
      expect(subject['restaurant']).to eq(data)
    end

    it "returns single guest" do
      data = Api::V1::GuestSerializer.new(reservation.guest).as_json.deep_stringify_keys
      expect(subject['guest']).to eq(data)
    end

    it "returns array of tables" do
      data = reservation.tables.map { Api::V1::TableSerializer.new(_1).as_json.deep_stringify_keys }
      expect(subject['tables']).to eq(data)
    end
  end

  describe "notes" do
    it "is nil if an empty string" do
      reservation.notes = ""
      expect(subject['notes']).to eq(nil)
    end
  end

  describe "#as_json" do
    it "returns correct payload" do
      expect(subject.except('guest', 'restaurant', 'tables')).to eq(
        'id'         => "RE100",
        'status'     => "not_confirmed",
        'covers'     => 2,
        'walk_in'    => false,
        'start_time' => reservation.start_time.iso8601,
        'duration'   => 5400,
        'notes'      => nil,
        'created_at' => reservation.created_at.iso8601,
        'updated_at' => reservation.updated_at.iso8601
      )
    end
  end
end
