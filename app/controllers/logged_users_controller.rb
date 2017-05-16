class LoggedUsersController < ApplicationController

  before_action :authenticate_user!

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.json { render json: current_user, status: :ok }
      else
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:nick_name)
    end
end