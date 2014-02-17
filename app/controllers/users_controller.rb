class UsersController < ApplicationController
  def new
	@user = User.new
  end

  def show
	@users = User.all
  end
end
