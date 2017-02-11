# == Schema Information
#
# Table name: executives
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Executive < ActiveRecord::Base

  belongs_to :board_memberships,
  primary_key: :id,
  foreign_key: :member_id,
  class_name: :BoardMembership
end
