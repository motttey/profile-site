# encoding: utf-8
class UsersController < ApplicationController
    def index
  		@users = UserDetail.all
    end

    def show
		@user = UserDetail.find_by(:username => params[:username])
    end

    def edit
		@user = UserDetail.find_by(:username => params[:username])
    end

    def update
    	@user = UserDetail.find_by(:username => params[:username])

    	if @user.update( user_params )
    		# 成功時の処理
    	    redirect_to 'index'
    	else
      		render 'edit'
    	end
    end
  private

    def user_params
      params.require(:username).permit(:name, :nickname, :about)
    end
end