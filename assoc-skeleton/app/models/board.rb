# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Board < ActiveRecord::Base

  has_many :board_memberships,
  primary_key: :id,
  foreign_key: :board_id,
  class_name: :BoardMembership
end
