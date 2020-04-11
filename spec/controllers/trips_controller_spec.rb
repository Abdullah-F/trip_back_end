require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  before do
    sign_in_user
  end
  describe 'GET #index' do
    let(:trips) { build_stubbed_list(:trip, 1) }
    it 'returns http success' do
      expect(Trip).to receive(:all).and_return(trips)
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let(:trip) { build_stubbed(:trip) }
    context 'when found' do
      it 'returns http ok' do
        expect(Trip).to receive(:find).and_return(trip)
        get :show, params: { id: trip.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not found' do
      it 'returns http ok' do
        expect(Trip).to receive(:find) do
          raise ActiveRecord::RecordNotFound
        end
        get :show, params: { id: trip.id }
        expect(response).to be_not_found
      end
    end
  end

  describe 'POST #create' do
    before do
      expect(Trip::CreateTrip).to receive(:call)
        .with(trip_params: permitted_params)
        .and_return(context)
    end
    context 'when created' do
      let(:trip) { double(:trip, id: 1, status: "ready") }
      let(:context){
        double(:context, success?: true, trip: trip)
      }
      let(:trip_params) { attributes_for(:trip) }
      let(:permitted_params) do
        ActionController::Parameters.new(trip_params).permit(trip_params.keys)
      end

      it 'returns http sccess' do
        post :create, params: { trip: trip_params }
        expect(response).to be_successful
      end
    end

    context 'invalid params' do
      let(:context){
        double(:context, success?: false, errors: [])
      }
      let(:invalid_trip_params) { attributes_for(:trip, :with_invalid_status) }
      let(:permitted_params) do
        ActionController::Parameters.new(invalid_trip_params)
          .permit(invalid_trip_params.keys)
      end

      it 'returns http unproceeable entity' do
        post :create, params: { trip: invalid_trip_params }
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #update' do
    context 'when updated' do
      let(:trip) { double(:trip, id: 1, status: "ready") }
      let(:context){
        double(:context, success?: true, trip: trip)
      }
      let(:event) { 'go' }
      let(:trip_params) do
        { event: event, trip: trip}
      end
      before do
        expect(Trip::Organizers::Update).to receive(:call)
          .with(trip_params)
          .and_return(context)
        expect(Trip).to receive(:find).and_return(trip)
      end
      it 'returns http success' do
        post :update, params: { id: trip.id, trip: { event: event }  }
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #destroy' do
    let(:trip) { build_stubbed(:trip) }
    context 'when found' do
      it 'returns http ok' do
        expect(Trip).to receive(:find).and_return(trip)
        expect(trip).to receive(:destroy).and_return(trip)
        get :destroy, params: { id: trip.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not found' do
      it 'returns http not found' do
        expect(Trip).to receive(:find) do
          raise ActiveRecord::RecordNotFound
        end
        get :destroy, params: { id: trip.id }
        expect(response).to be_not_found
      end
    end
  end
end
