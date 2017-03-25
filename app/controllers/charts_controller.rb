class ChartsController < ApplicationController

  before_action :signed_in_user # user must be signed in
  before_action :correct_user   # signed in user must be current user

  def dashboard
  end
end
