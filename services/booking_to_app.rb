class BookingToApp
    def initialize(request, author)
        @request = request
        @author = author
        @anon_client_req = !request.client_id
    end

    def perform!
        create_app
        update_req
        anon_client_note
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
    def anon_client_note
        if !@request.client_id
            note = AppointmentNote.new(
                note: "Client Name: #{@request.anon_name}\n Client Phone: #{@request.anon_phone}",
                active: true,
                appointment_id: @appointment.id,
                author_id: @author,
                last_update: Time.now,
                date_created: Time.now
              )
              note.save
        end
    end
    def update_req
       @request.appointment_id = @appointment.id
    end

end