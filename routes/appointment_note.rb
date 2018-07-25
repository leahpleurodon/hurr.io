get '/appointment_note/:id' do
    if logged_in_employee
      @note = AppointmentNote.find(params[:id])
    elsif session[:appointment_id] == AppointmentNote.find(params[:id]).appointment_id
      @note = AppointmentNote.find(params[:id])
    else
      redirect '/'
    end
  end
  
  get '/appointment_notes' do
    if logged_in_employee
      @notes = AppointmentNote.where(active: true)
    else
      redirect '/'
    end
  end
  
  post '/appointment_note' do
    if logged_in_employee
      note = AppointmentNote.new(
        note: params["note"],
        active: true,
        appointment_id: params["appointment-id"],
        author_id: session[:employee_id],
        last_update: Time.now,
        date_created: Time.now
      )
      note.save
      redirect "/appointments/#{params["appointment-id"]}"
    else
      redirect '/'
    end
  end
  
  get '/appointment_notes/:id/edit' do
    if logged_in_employee
      @note = AppointmentNote.find(params[:id])
      erb :"appointment_notes/edit", layout: :'layouts/admin'
    else
      redirect '/'
    end
  end
  
  put '/appointment_notes/:id/deactivate' do
    if logged_in_employee
      note = AppointmentNote.find(params[:id])
      note.active = false
      note.save
      redirect "/appointments/#{note.appointment_id}"
    else
      redirect '/'
    end
  end
  
  put '/appointment_notes/:id' do
    if logged_in_employee
      note = AppointmentNote.find(params[:id])
      note.note = params["note"]
      note.save
      redirect "/appointments/#{note.appointment_id}"
    else
      redirect '/'
    end
  end