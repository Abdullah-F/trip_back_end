require 'spec_helper'

RSpec.describe Trip::CreateTrip, type: :interactor do
  describe '.call' do
    context 'when given valid params' do
      let(:trip_params) { attributes_for(:trip) }
      let(:trip){ build_stubbed(:trip, trip_params) }
      let(:driver) { build_stubbed(:driver) }
      let(:drivers_ids) { [driver.id] }
      let(:result) do
        described_class.call({
          trip_params: trip_params,
          drivers_ids: drivers_ids
       })
      end
      before do
        expect(Trip).to receive(:create!).with(trip_params).and_return(trip)
        expect(Driver).to receive(:find).with(drivers_ids).and_return(driver)
        allow(trip).to receive(:drivers).and_return([])
      end
      it 'succeeds' do
        expect(result).to be_a_success
      end

      it 'returns a trip' do
        expect(result.trip).to be trip
      end
    end

    context 'when given invalid params' do
      let(:result) { described_class.call }
      before do
        expect(Trip).to receive(:create!) {
          raise ActiveRecord::RecordInvalid
        }
      end
      it 'fails' do
        expect(result).not_to be_a_success
      end

      it 'returns a trip' do
        expect(result.trip).to be nil
      end
    end
  end
end
