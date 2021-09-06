require "rails_helper"

RSpec.describe Guest, type: :model do
  describe "attributes" do
    subject(:guest) { Guest.new(id, "fname", "lname") }

    let(:id) { nil }

    it "sets attributes to specified values" do
      expect(guest.first_name).to eql "fname"
      expect(guest.last_name).to eql "lname"
      expect(guest.created_at).to_not be_nil
      expect(guest.updated_at).to_not be_nil
    end

    describe "id" do
      context "when id is set as nil" do
        it "sets id to a random value" do
          expect(guest.id.length).to eql SecureRandom.uuid.length
        end
      end

      context "when id is present" do
        let(:id) { "G100" }

        it "sets id to the passed value" do
          expect(guest.id).to eql "G100"
        end
      end
    end
  end
end
