require 'rails_helper'

RSpec.describe Driver, type: :model do
  describe 'columns' do
    let(:column_names) { described_class.column_names }
    it 'has a name columns' do
      expect(column_names).to include('name')
    end

    it 'has created_at column' do
      expect(column_names).to include('created_at')
    end

    it 'has updated_at column' do
      expect(column_names).to include('updated_at')
    end

    it 'has a trip_id column' do
      expect(column_names).to include('trip_id')
    end
  end

  describe 'realtions' do
    let(:driver) { create(:driver) }

    it 'belongs to a trip' do
      expect(driver.respond_to?(:trip)).to be true
    end
  end
end
