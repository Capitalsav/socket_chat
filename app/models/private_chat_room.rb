# == Schema Information
#
# Table name: private_chat_rooms
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PrivateChatRoom < ApplicationRecord
  has_one :membership
  has_one :owner, class_name: 'User', through: :membership
  has_one :member, class_name: 'User', through: :membership
  accepts_nested_attributes_for :membership
  has_many :private_messages, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30}, uniqueness: true

  def self.check_private_chat(owner, member)
    membership = Membership.find_by(owner_id: owner, member_id: member)
    if membership.nil?
      Membership.find_by(owner_id: member, member_id: owner)
    else
      membership
    end
  end
end
