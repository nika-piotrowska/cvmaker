class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def index; end

  def dashboard
    @cvs = current_user.cvs
  end

end
