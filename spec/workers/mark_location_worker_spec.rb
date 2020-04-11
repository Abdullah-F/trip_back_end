require 'rails_helper'

RSpec.describe MarkLocationWorker, type: :worker do
  describe '#perform' do
    let(:trip) { build_stubbed(:trip) }
    let(:location_params) { attributes_for(:location).merge(trip_id: trip.id) }
    let(:worker) { described_class.new }
    let(:trip) { build_stubbed(:trip, :with_ongoing_status) }
    it 'creates a new location' do
      expect(Location).to receive(:create!).with(location_params)
        .and_return(nil)
      worker.perform(location_params)
    end
  end
end
