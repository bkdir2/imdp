class UsersController < ApplicationController
  def new
	@users = User.all
  end
end
