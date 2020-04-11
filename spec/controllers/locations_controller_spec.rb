require 'rails_helper'

RSpec.describe LocationsController do
  before do
    sign_in_user
  end

  describe 'POST #create' do
    let(:location_params) do
      attributes_for(:location, :with_a_string_trip_id)
    end
    let(:permitted_params) do
      ActionController::Parameters.new(location_params)
        .permit(location_params.keys)
    end
    before do
      expect(Location::Create).to receive(:call)
        .with(location_params: permitted_params).and_return(context)
      post :create, params: { location: location_params }
    end
    context 'when accepted' do
      let(:context) do
        double(:context, success?: true)
      end

      it 'returns http success' do
        expect(response).to be_successful
      end
    end

    context 'when invalid request' do
      let(:context) do
        double(:context, success?: false)
      end
     it 'returns http failer' do
       expect(response).not_to be_successful
     end
    end
  end
end
