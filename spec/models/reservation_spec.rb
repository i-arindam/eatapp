require "rails_helper"

RSpec.describe Reservation, type: :model do
  describe "attributes" do
    subject(:reservation) do
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

    let(:reservation_id) { nil }
    let(:notes) { nil }
    let(:guest) { nil }
    let(:restaurant) { nil }
    let(:tables) { nil }

    it "sets attributes to specified values" do
      expect(reservation.status).to eql "not_confirmed"
      expect(reservation.covers).to be 2
      expect(reservation.walk_in).to be false
      expect(reservation.start_time.strftime("%F")).to eql 10.days.ago.strftime("%F")
      expect(reservation.duration).to be 5400
      expect(reservation.notes).to be_nil
      expect(reservation.guest).to be_nil
      expect(reservation.restaurant).to be_nil
      expect(reservation.tables).to be_nil

      expect(reservation.created_at).to_not be_nil
      expect(reservation.updated_at).to_not be_nil
    end

    describe "id" do
      context "when id is set as nil" do
        it "sets id to a random value" do
          expect(reservation.id.length).to eql SecureRandom.uuid.length
        end
      end

      context "when id is present" do
        let(:reservation_id) { "RE100" }

        it "sets id to the passed value" do
          expect(reservation.id).to eql "RE100"
        end
      end
    end
  end
end
