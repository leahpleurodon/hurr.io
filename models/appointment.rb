class Appointment < ActiveRecord::Base
    belongs_to :client
    belongs_to :employee, foreign_key: 'author_id'
    belongs_to :employee, foreign_key: 'employee_id'
    has_many :appointment_notes
    belongs_to :booking_request
end