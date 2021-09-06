require "rails_helper"

RSpec.describe Table, type: :model do
  describe "attributes" do
    subject(:table) { Table.new(id, "Table1", 200) }

    let(:id) { nil }

    it "sets attributes to specified values" do
      expect(table.number).to eql "Table1"
      expect(table.max_covers).to be 200
      expect(table.created_at).to_not be_nil
      expect(table.updated_at).to_not be_nil
    end

    describe "id" do
      context "when id is set as nil" do
        it "sets id to a random value" do
          expect(table.id.length).to eql SecureRandom.uuid.length
        end
      end

      context "when id is present" do
        let(:id) { "T100" }

        it "sets id to the passed value" do
          expect(table.id).to eql "T100"
        end
      end
    end
  end
end
