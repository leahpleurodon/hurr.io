class AppointmentNote < ActiveRecord::Base
    belongs_to :appointment
    belongs_to :employee, foreign_key: 'author_id'
end