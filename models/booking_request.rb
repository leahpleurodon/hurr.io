class BookingRequest < ActiveRecord::Base
    belongs_to :client
    belongs_to :employee
    belongs_to :appointment
    

end