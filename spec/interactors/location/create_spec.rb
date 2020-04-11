require 'spec_helper'

RSpec.describe Location::Create do
  describe '.call' do
    let(:location_params) { attributes_for(:location, :with_a_trip_id) }
    it 'schedules the creation of a new marked location' do
      expect(MarkLocationWorker).to receive(:perform_async)
        .with(location_params).and_return(nil)
      described_class.call(location_params: location_params)
    end
  end
end
