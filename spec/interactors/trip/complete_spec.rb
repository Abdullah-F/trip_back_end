require 'spec_helper'

RSpec.describe Trip::Complete, type: :interactor do
  describe '.call' do
    context 'when the right event is given' do
      let(:event) { :complete }
      let(:trip) { build_stubbed(:trip, :with_ongoing_status) }
      let(:result) do
        described_class.call(event: event, trip: trip)
      end
      before do
        expect(trip).to receive(:save).and_return(true)
      end
      it 'succeeds' do
        expect(result).to be_a_success
      end

      it 'results in an updated trip' do
        expect(result.trip).to be trip
      end

      it 'updates the trip status correctly' do
        expect{ result }.to change{ trip.status }
          .from('ongoing').to('completed')
      end
    end

    context 'when the wrong event is given' do
      let(:event) { :ongoing }
      let(:trip) { build_stubbed(:trip, :with_ongoing_status) }
      let(:result) do
        described_class.call(event: event, trip: trip)
      end
      it 'fails' do
        expect(result).to be_a_success
      end

      it 'returns unpdated trip' do
        expect(result.trip).to be trip
      end

      it 'does not change the status of the trip' do
        expect(trip.status).to eq 'ongoing'
      end
    end
  end
end
