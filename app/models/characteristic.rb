# == Schema Information
#
# Table name: characteristics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :integer
#  created_at :datetime
#  updated_at :datetime
#

class Characteristic < ActiveRecord::Base
	belongs_to :user
	belongs_to :event
end
