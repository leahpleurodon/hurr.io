
get '/appointments' do
    redirect '/' unless logged_in_employee
    @appointments = Appointment.where(active: true)
    erb :"appointments/index", layout: :'layouts/admin'
end

get '/appointments/:id/edit' do
    redirect '/' unless logged_in_employee
        @employees = Employee.where(active: true, terminated: false)
        @appointment = Appointment.find(params[:id])
        erb :"appointments/edit", layout: :'layouts/admin'
end

get '/appointments/:id' do
    redirect '/' unless logged_in_employee
        @appointment = Appointment.find(params[:id])
        @appointment_notes = AppointmentNote.where(appointment_id: params[:id], active: true)
        erb :"appointments/show", layout: :'layouts/admin'
end

put '/appointments/:id' do
    redirect '/' unless logged_in_employee
        appointment = Appointment.find(params[:id])
        appointment.employee_id = params['employee-id']
        appointment.app_date = params['app-date']
        appointment.start_time = params['start-time']
        appointment.app_service = params['app-service']
        appointment.end_time = params['end-time']
        appointment.last_updated = Time.now
        appointment.save
        redirect '/appointments'
end

get '/clients/:id/appointments/new' do
    redirect '/' unless logged_in_employee
        @employees = Employee.where(active: true, terminated: false)
        @client = Client.find(params[:id])
    erb :"appointments/new", layout: :'layouts/admin'
end

put '/appointments/:id/delete' do
    redirect '/' unless logged_in_employee
        appointment = Appointment.find(params[:id])
        appointment.active = false
        appointment.save
        redirect '/appointments'
end

post '/appointments' do
    redirect '/' unless logged_in_employee
        appointment = Appointment.new(
            employee_id: params['employee-id'],
            client_id: params['client-id'],
            app_date: params['app-date'],
            start_time: params['start-time'],
            app_service: params['app-service'],
            end_time: params['end-time'],
            author_id: session[:employee_id],
            last_updated: Time.now,
            date_created: Time.now,
            active: true
        )
        appointment.save
        redirect '/appointments'
end