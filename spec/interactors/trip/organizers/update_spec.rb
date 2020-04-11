require 'spec_helper'

RSpec.describe Trip::Organizers::Update, type: :interactor do
  describe '.call' do
    it 'orgnizes two interactors' do
      expect(described_class.organized).to eq([Trip::Start, Trip::Complete])
    end
  end
end
