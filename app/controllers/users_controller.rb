class UsersController < ApplicationController
  before_action :correct_user, only: [:show]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #binding.irb
      if @user.save
        UserMailer.with(to: @user.email, name: @user.name).welcome.deliver_later
        #AsyncLogJob.set(wait: 10.seconds).perform_later(@user.email, @user.name)
        log_in(@user)
        redirect_to user_path(@user.id), notice: 'アカウントを登録しました。'
      else
        render :new
      end
 
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
