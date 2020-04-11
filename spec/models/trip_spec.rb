require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'columns' do
    let(:column_names) { described_class.column_names }
    it 'has status column' do
      expect(column_names).to include('status')
    end

    it 'has an id column' do
      expect(column_names).to include('id')
    end

    it 'has a created_at column' do
      expect(column_names).to include('created_at')
    end

    it 'has an updated_at column' do
      expect(column_names).to include('updated_at')
    end
  end

  describe ' enumerized columns' do
    describe 'statuses' do
      it 'is enumerized' do
        expect(described_class.statuses).not_to be_empty
      end

      it 'has a ready status' do
        expect(described_class.statuses.keys).to include('ready')
        expect(described_class.statuses['ready']).to be 0
      end
      it 'has an ongoing status' do
        expect(described_class.statuses.keys).to include('ongoing')
        expect(described_class.statuses['ongoing']).to be 1
      end

      it 'has a completed status' do
        expect(described_class.statuses.keys).to include('completed')
        expect(described_class.statuses['completed']).to be 2
      end

      context 'when invalid' do
        let(:invalid_trip) { build(:trip, :with_invalid_status) }
        it 'raises an ArgumentError error' do
          expect { invalid_trip }.to raise_error ArgumentError
        end
      end
    end
  end

  describe 'relations' do
    let(:trip) { create(:trip) }
    it 'has one or more drivers' do
      expect(trip.respond_to?(:drivers)).to be true
    end

    it 'has one or more locations' do
      expect(trip.respond_to?(:locations)).to be true
    end
  end

  describe 'validation' do
    describe 'status' do
      context 'when valid' do
        let(:trip) { build(:trip) }
        it 'becomes valid' do
          expect(trip).to be_valid
        end
      end
    end
  end

  describe 'aasm' do
    describe 'status' do
      context 'when ready' do
        let(:trip) { build(:trip) }

        it 'is ready' do
          expect(trip).to have_state(:ready).on(:status)
        end

        context 'when valid transition' do
          it 'can transition to ongoing' do
            expect(trip).to allow_event(:go).on(:status)
            expect(trip).to transition_from(:ready).to(:ongoing).on_event(:go)
              .on(:status)
          end
        end

        context 'when invalid transition' do
          it 'can not transion to completed' do
            expect(trip).not_to allow_event(:complete).on(:status)
            expect(trip).not_to transition_from(:ready).to(:complete)
              .on_event(:go).on(:status)
          end
        end
      end

      context 'when ongoing' do
        let(:trip) { build(:trip, :with_ongoing_status) }

        it 'is ongoing' do
          expect(trip).to have_state(:ongoing).on(:status)
        end

        context 'when valid transition' do
          it 'can transition to completed' do
            expect(trip).to allow_event(:complete).on(:status)
            expect(trip).to transition_from(:ongoing).to(:completed)
              .on_event(:complete).on(:status)
          end
        end

        context 'when invalid transition' do
          it 'can not transition to completed' do
            expect(trip).not_to allow_event(:ongoing).on(:status)
            expect(trip).not_to transition_from(:ongoing).to(:ready)
              .on_event(:complete).on(:status)
          end
        end
      end

      context 'when completed' do
        let(:trip) { build(:trip, :with_completed_status) }

        it 'is completed' do
          expect(trip).to have_state(:completed).on(:status)
        end

        context 'when invalid transition' do
          it 'can not transition to completed or ongoing' do
            expect(trip).not_to allow_event(:ongoing).on(:status)
            expect(trip).not_to allow_event(:completed).on(:status)
          end
        end
      end
    end
  end
end
