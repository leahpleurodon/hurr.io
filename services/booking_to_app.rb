class BookingToApp
    def initialize(request, author)
        @request = request
        @author = author
        @anon_client_req = !request.client_id
    end

    def perform!
        create_app
        update_req
        self
    end
    def create_app
        client_id = !!@request.client_id ? @request.client_id : Client.where(first_name: "anonymous")[0].id
        @appointment = Appointment.new(
            employee_id: @request.employee_id,
            client_id: client_id,
            app_date: @request.app_date,
            start_time: @request.start_time,
            app_service: @request.app_service,
            end_time: @request.end_time,
            author_id: @author,
            last_updated: Time.now,
            date_created: Time.now,
            active: true
        )
        @appointment.save
    end
    def update_req
       @request.appointment_id = @appointment.id
    end

end