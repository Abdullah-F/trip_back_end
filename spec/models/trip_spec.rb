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

      it 'has an ongoing status' do
        expect(described_class.statuses.keys).to include('ongoing')
      end

      it 'has a completed status' do
        expect(described_class.statuses.keys).to include('completed')
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
end
