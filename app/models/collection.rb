class Collection < ActiveRecord::Base
    belongs_to :user
    validates :destination, :start_date, :end_date, :trip_summary, presence: true
end