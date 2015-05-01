class Relation < ActiveRecord::Base
	belongs_to :user_id, :class_name => "User"
	belongs_to :event_id, :class_name => "Event"
end
