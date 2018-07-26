require_relative "../services/availability_gen"
require_relative "../services/booking_to_app"


get '/get_times' do
    @date =  params[:date] ? params[:date] : Date.today
    @shifts = EmpWorkHour.where(work_date: @date)
    @appointments = Appointment.where(app_date: @date)
    @emp_availability = AvailabilityGen.new(@appointments,@shifts).generate!.emp_available_times
    erb :"booking_requests/get_times"
end

get '/request_booking' do
    
    redirect '/get_times' unless !!params['start-time']
    @start_time = params['start-time']
    @date = Date.parse(params['date'])
    @employee = Employee.find(params['employee'])
    @client = session[:client_id]
    erb :"booking_requests/new"
end

post '/booking_request' do
    redirect '/get_times' unless !!params['start-time']
    br = BookingRequest.new(
        employee_id: params['employee-id'],
        client_id: session[:client_id] || nil,
        anon_phone: params['anon-phone'],
        anon_name: params['anon-name'],
        app_date: Date.parse(params['date']),
        start_time: Time.parse(params['start-time']),
        app_service: params['service'],
        end_time: Time.parse(params['start-time']) + 90.minutes,
        request_status: 'new',
        last_updated: Time.now,
        date_created: Time.now,
        active: true
    )
    br.save
    redirect '/thanks'
end

get '/booking_requests' do
    redirect '/' unless !!logged_in_employee
        if !!params['status'] 
            @requests =  BookingRequest.where(active: true, request_status: params['status'])
        else
            @requests = BookingRequest.where(active: true)
        end
        erb :'booking_requests/index'

end



put '/booking_request/:id/deny' do
    redirect '/' unless logged_in_employee
    br = BookingRequest.find(params[:id])
    br.request_status = 'denied'
    br.save
    redirect '/booking_requests'

end

put '/booking_request/:id/delete' do
    redirect '/' unless logged_in_employee
    br = BookingRequest.find(params[:id])
    br.active = false
    br.save
    redirect '/booking_requests'
end

put '/booking_request/:id/approve' do
    redirect '/' unless logged_in_employee
    br = BookingRequest.find(params[:id])
    br.request_status = 'approved'
    convert_to_app = BookingToApp.new(br, session[:employee_id]).perform!
    br.save
    redirect '/booking_requests'

end