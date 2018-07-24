require 'pry'
get '/employees' do
  if admin_logged_in?
    @employees = Employee.where(active: true)
    erb :'employees/index', layout: :'layouts/admin'
  else
    redirect '/'
  end
end
  
get '/employees/:id' do
  if admin_logged_in?
    @employee = Employee.find(params[:id])
    erb :"employees/show", layout: :'layouts/admin'
  else
    redirect '/'
  end
end

get '/employee/new' do
  if admin_logged_in?
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/new", layout: :'layouts/admin'
  else 
    redirect '/'
  end
end

post '/employee' do
  if admin_logged_in?
    employee = Employee.new(
      first_name: params["first-name"],
      password: params["first-name"]|| params["first-name"],
      last_name: params["last-name"],
      preferred_name: params["preferred-name"] || params["first-name"],
      title: params["title"],
      email: params["email"],
      dob: params["dob"],
      phone: params["phone"],
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
  else
    redirect '/'
  end
end

get '/employees/:id/edit' do
  if admin_logged_in?
    @employee = Employee.find(params[:id])
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/edit", layout: :'layouts/admin'
  else
    redirect '/'
  end
end

put '/employees/:id/deactivate' do
  if admin_logged_in?
    employee = Employee.find(params[:id])
    employee.active = false
    employee.save
    redirect "/employees"
  else
    redirect '/'
  end
end

put '/employees/:id' do
  if admin_logged_in?
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
    employee.date_terminated = params["date-terminated"] || nil
    employee.last_update = Time.now
    employee.save
    redirect "/employees/#{employee.id}"
  else
    redirect '/'
  end
end

