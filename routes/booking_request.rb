require_relative "../services/availability_gen"
require 'pry'
get '/get_times' do
    @date =  params[:date] ? params[:date] : Date.today
    @shifts = EmpWorkHour.where(work_date: @date)
    @appointments = Appointment.where(app_date: @date)
    @emp_availability = AvailabilityGen.new(@appointments,@shifts).generate!.emp_available_times
    erb :"booking_request/get_times"
end

get '/request_booking' do
    
    redirect '/get_times' unless !!params['start-time']
    @start_time = params['start-time']
    @date = Date.parse(params['date'])
    @employee = Employee.find(params['employee'])
    @client = session[:client_id]
    erb :"booking_request/new"
end

post '/booking_request' do
    redirect '/get_times' unless !!params['start-time']
    br = BookingRequest.new(
        start_time: params['start-time'],
        employee_id: params['employee-id'],
        client: session[:client_id] || nil,
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
    redirect '/'
end

get '/booking_requests' do
    # redirect '/' unless !!logged_in_employee
    @requests = !!params['status']  ? BookingRequest.where(active: true) : BookingRequest.where(active: true, status: params['status'])
    erb :'booking_requests/index'

end
