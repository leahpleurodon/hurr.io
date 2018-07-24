
get '/employees' do
    @employees = Employee.where(active: true)
    erb :'employees/index', layout: :'layouts/admin'
  end
  
  get '/employees/:id' do
    @employee = Employee.find(params[:id])
    erb :"employees/show", layout: :'layouts/admin'
  end
  
  get '/employee/new' do
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/new", layout: :'layouts/admin'
  end
  
  post '/employee' do
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
  end
  
  get '/employees/:id/edit' do
    @employee = Employee.find(params[:id])
    @titles = %w(Mrs Mr Miss Miss Master Sir Lady Lord Dr)
    erb :"employees/edit", layout: :'layouts/admin'
  end
  
  put '/employees/:id/deactivate' do
      employee = Employee.find(params[:id])
      employee.active = false
      employee.save
      redirect "/employees"
  end

  put '/employees/:id' do
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
  end

  