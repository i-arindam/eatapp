require "rails_helper"

RSpec.describe 'Guest' do
  let(:guest) { Guest.new(nil, 'a', 'b')}
  it do
    expect(guest).to be_a Guest
  end
end
