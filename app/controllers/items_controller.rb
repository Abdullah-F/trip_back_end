class ItemsController < ApplicationController

  def index
    render json: { hi: 'indx is an action' }
  end
end
