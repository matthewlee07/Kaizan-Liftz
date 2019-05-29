class UsersController < ApplicationController

    # CREATE
    def create
        @user = User.new(user_params)
        # session[:return_to] ||= request.referer
        if @user.save
            log_in @user
            redirect_to(root_path)
        else
            render :new
        end
    end

    def new
        @user = User.new if @user == nil
    end

    # READ
    def show
        @user = User.find(params[:id])
    end

    # ADMIN ONLY
    # def index 
    #     @users = User.paginate(page: params[:page], :per_page => 10)
    # end

    # UPDATE
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end

    # DESTROY
    def destroy
        User.find(params[:id]).destroy        
        redirect_to root_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end