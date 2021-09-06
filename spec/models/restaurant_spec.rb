require "rails_helper"

RSpec.describe Restaurant, type: :model do
  describe "attributes" do
    subject(:restaurant) { Restaurant.new(id, "Resto", "This Street") }

    let(:id) { nil }

    it "sets attributes to specified values" do
      expect(restaurant.name).to eql "Resto"
      expect(restaurant.address).to eql "This Street"
    end

    describe "id" do
      context "when id is set as nil" do
        it "sets id to a random value" do
          expect(restaurant.id.length).to eql SecureRandom.uuid.length
        end
      end

      context "when id is present" do
        let(:id) { "R100" }

        it "sets id to the passed value" do
          expect(restaurant.id).to eql "R100"
        end
      end
    end
  end
end
