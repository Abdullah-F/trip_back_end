require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'columns' do
    let(:column_names) { described_class.column_names }
    it 'has a lat column' do
      expect(column_names).to include('lat')
    end

    it 'has a lng column' do
      expect(column_names).to include('lng')
    end

    it 'has a cteated_at column' do
      expect(column_names).to include('created_at')
    end

    it 'has an updated_at column' do
      expect(column_names).to include('updated_at')
    end

    it 'has a trip_id column' do
      expect(column_names).to include('trip_id')
    end
  end

  describe 'relations' do
    let(:location) { create(:location, :with_a_trip) }
    it 'belongs_to a trip' do
      expect(location.respond_to?(:trip)).to be true
    end
  end
end
