require 'pry'

post '/employees/:id/image' do
  redirect '/' unless admin_logged_in?
    tempfile = params[:file][:tempfile] 
    fileext = File.extname(params[:file][:filename])
    img_path = "/uploads/photos/employee/employee_#{params[:id]}#{fileext}"
    FileUtils.cp(tempfile.path, "#{FileUtils.pwd}/public/#{img_path}")
    emp = Employee.where(id: params[:id])[0]
    emp.photo = img_path
    emp.save
    redirect "/employees/#{params[:id]}"
end

get '/employees' do
  redirect '/' unless admin_logged_in?
    if params['see-terminated'] == 'true'
      @employees = Employee.where(active: true, terminated: true)
    else
      @employees = Employee.where(active: true, terminated: false)
    end
    erb :'employees/index', layout: :'layouts/admin'
end
  
get '/employees/:id' do
  redirect '/' unless admin_logged_in?
    @employee = Employee.find(params[:id])
    erb :"employees/show", layout: :'layouts/admin'
end

get '/employee/new' do
  redirect '/' unless admin_logged_in?
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/new", layout: :'layouts/admin'
end

post '/employee' do
  redirect '/' unless admin_logged_in?
    employee = Employee.new(
      first_name: params["first-name"],
      password: params["first-name"]|| params["first-name"],
      last_name: params["last-name"],
      preferred_name: params["preferred-name"] || params["first-name"],
      title: params["title"],
      email: params["email"],
      dob: params["dob"],
      phone: params["phone"],
      photo: params["photo"],
      active: true,
      admin: params["admin"],
      date_started: Time.now,
      terminated: false,
      date_terminated: params["date-terminated"] || nil,
      last_update: Time.now,
      date_created: Time.now 
    )
    employee.save
    redirect "/employees"
end

get '/employees/:id/edit' do
  redirect '/' unless admin_logged_in?
    @employee = Employee.find(params[:id])
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/edit", layout: :'layouts/admin'
end

put '/employees/:id/deactivate' do
  redirect '/' unless admin_logged_in?
    employee = Employee.find(params[:id])
    employee.active = false
    employee.save
    redirect "/employees"
end

put '/employees/:id' do
  redirect '/' unless admin_logged_in?
    employee = Employee.find(params[:id])
    employee.first_name = params["first-name"]
    employee.password = params["first-name"]
    employee.last_name = params["last-name"]
    employee.preferred_name = params["preferred-name"] || params["first-name"]
    employee.title = params["title"]
    employee.email = params["email"]
    employee.dob = params["dob"]
    employee.phone = params["phone"]
    employee.admin = params["admin"] ? true : false
    employee.terminated = params["terminated"] || false
    employee.photo = params["photo"],
    employee.date_terminated = params["date-terminated"] || nil
    employee.last_update = Time.now
    employee.save
    redirect "/employees/#{employee.id}"
end



