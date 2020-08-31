class UsersController < ApplicationController

    before_action :authorize_request, except: [:create, :login]
    before_action :find_user, only: [:show, :update]

    def index
        # filter out yoruself from user list
        users_list = User.all.filter do |user| user.id != @current_user.id end 
        # add if you are friends
        render json: {users: users_list}, status: :ok
    end

    def show
        render json: find_user(params[:user][:id]), status: :ok
    end

    def create
        # byebug
        @user = User.new(user_params(:first_name, :last_name, :username, :password))
        if @user.save
            token = User.encode(@user)
            render json: {token: token, user_id: @user.id}, status: :created 
            # render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages },
                    status: :unprocessable_entity
        end
    end

    def update

    end

    def login

        creds = params[:user]
        # 1) check if user exists - lets use a method > check_user
        @user = User.check_user(creds)
        # byebug
        # 2) if I do have that user and the UN and PW check out, then grant token
        if (@user) 
            token = User.encode(@user)
            render json: {token: token, user_id: @user.id}, status: :ok  # token.to_json()
        # elsif user doesnt exist "if @user == nil"

        # else "if @user == false"
        else
            render json: {error: 'unauthorized' }, status: :unauthorized
        end
        # 3) send token to client in a json object

    end

    def check
        if @current_user
            render json: @current_user.to_json()
        end
    end
    

    private

    def find_user(id)
        @user = User.find(id)
    end

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end
