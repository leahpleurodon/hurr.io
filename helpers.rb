def get_week_day(date)
    date.strftime("%A").downcase
end
def get_date_string(date)
    date.strftime("%Y-%m-%d")
end
def get_time_string(time)
    time.strftime("%H:%M")
end
def logged_in_client
    Client.where(id: session[:client_id])[0]
end
def logged_in_employee
    Employee.where(id: session[:employee_id])[0]
end
def admin_logged_in?
    logged_in_employee && logged_in_employee.admin
end