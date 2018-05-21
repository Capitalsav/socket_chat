# == Schema Information
#
# Table name: multi_user_private_chat_rooms
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MultiUserPrivateChatRoom < ApplicationRecord
  has_many :multi_user_memberships, dependent: :destroy
  has_many :multi_user_messages, dependent: :destroy
  belongs_to :user
  has_many :users, through: :multi_user_memberships
  validates :name, presence: true, length: { maximum:30}, uniqueness: true
end
