class ChatroomsController < ApplicationController
    before_action :authorize_request

    def index 
        render json: Chatroom.all
    end

    def create
        # byebug
        chat_room = Chatroom.new(user_id: @current_user.id, chatroom_name: params[:chatroom_name])
        if chat_room.save
            render json: chat_room
        else
            render json: {errors: chat_room.errors.full_messages},
            status: 400
        end
    end

    def show
        chat_room = Chatroom.find(params[:id])
        render json: chat_room, include: [:messages]
    end

    def destroy
        chatroom = Chatroom.find(params[:id])
        # byebug
        if chatroom.messages.delete_all && chatroom.delete 
            render json: {messages: chatroom.messages.delete, chatroom: chatroom.delete}
        else
            render json: {errors: chatroom.errors.full_messages},
            status: 400
        end
    end

    private

    def chat_room_params(*args)
        params.require(:chatroom).permit(*args)
    end

end
