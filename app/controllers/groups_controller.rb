class GroupsController < ApplicationController

    before_action :authorize_request

    def index
        frienders = Group.where('friendee_id = ?', @current_user.id).map do |f| User.find(f.friender_id) end
        friendees = Group.where('friender_id = ?', @current_user.id).map do |f| User.find(f.friendee_id) end
        render json: {friends_list: (friendees + frienders).uniq}, status: 200
    end

    def create

        friendship = Group.new(friender_id: params[:friender_id], friendee_id: params[:friendee_id])
        
        if !Group.find_by(friendee_id: params[:friender_id], friender_id: params[:friendee_id]) && friendship.save
            render json: {friendship: friendship, new_friend: User.find(friendee_id)}, status: :ok
        else
            render json: {error: true, message: "Error adding friend" }, status: :unprocessable_entity
        end
    end
    
    private
    def group_params
        params.require(:groups).permit(:friender_id, :friendee_id)
    end
end
