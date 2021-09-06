# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ReservationSerializer do
  subject { serializer.as_json }

  let(:guest) { Guest.new("G100", "John", "Doe") }
  let(:restaurant) { Restaurant.new("R100", "This Resto", "That Street, Which City") }
  let(:tables) do
    2.times.map do |i|
      i += 1
      Table.new("Table#{i}", 10*i, 20*i)
    end
  end
  let(:reservation) do
    Reservation.new(
      reservation_id,
      "not_confirmed",
      2,
      false,
      10.days.ago,
      5400,
      notes,
      guest,
      restaurant,
      tables,
    )
  end
  let(:reservation_id) { "RE100" }
  let(:notes) { nil }

  let(:serializer)  { Api::V1::ReservationSerializer.new(reservation) }

  it "allows attributes to be defined for serialization" do
    expect(subject.keys).to contain_exactly(
      *%i(
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
      data = Api::V1::RestaurantSerializer.new(restaurant).as_json
      expect(subject[:restaurant]).to eql data
    end

    it "returns single guest" do
      data = Api::V1::GuestSerializer.new(reservation.guest).as_json
      expect(subject[:guest]).to eql data
    end

    it "returns array of tables" do
      data = reservation.tables.map { Api::V1::TableSerializer.new(_1).as_json }
      expect(subject[:tables]).to eql data
    end
  end

  describe "notes" do
    context "when notes is present" do
      let(:notes) { "This is a note" }

      it "returns the stored value for notes" do
        expect(subject[:notes]).to eql "This is a note"
      end
    end

    context "when notes is absent" do
      it "is nil if an empty string" do
        expect(subject[:notes]).to be_nil
      end
    end
  end

  describe "#as_json" do
    it "returns correct payload" do
      expect(subject.except(:guest, :restaurant, :tables)).to eql(
        :id         => "RE100",
        :status     => "not_confirmed",
        :covers     => 2,
        :walk_in    => false,
        :start_time => reservation.start_time.iso8601,
        :duration   => 5400,
        :notes      => nil,
        :created_at => reservation.created_at.iso8601,
        :updated_at => reservation.updated_at.iso8601
      )
    end

    context "when id is nil" do
      let(:reservation_id) { nil }

      it "sets id to a random value with fixed length" do
        expect(subject[:id].length).to eql SecureRandom.uuid.length
      end
    end
  end
end
