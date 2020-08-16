class Message < ApplicationRecord
    belongs_to :user
    belongs_to :encryption
    belongs_to :chatroom

    validates :message_text, presence: true

end
