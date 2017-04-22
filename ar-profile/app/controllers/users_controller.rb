# encoding: utf-8
class UsersController < ApplicationController
    def index
  		@users = UserDetail.all
    end

    def show
		@user = UserDetail.find_by(:username => params[:username])
    end
end