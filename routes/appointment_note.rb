get '/appointment_note/:id' do
    redirect '/' unless logged_in_employee
      @note = AppointmentNote.find(params[:id])
  end
  
  get '/appointment_notes' do
    redirect '/' unless logged_in_employee
    @notes = AppointmentNote.where(active: true)
  end
  
  post '/appointment_note' do
    redirect '/' unless logged_in_employee
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
  end
  
  get '/appointment_notes/:id/edit' do
    redirect '/' unless logged_in_employee
      @note = AppointmentNote.find(params[:id])
      erb :"appointment_notes/edit", layout: :'layouts/admin'
  end
  
  put '/appointment_notes/:id/deactivate' do
    redirect '/' unless logged_in_employee
      note = AppointmentNote.find(params[:id])
      note.active = false
      note.save
      redirect "/appointments/#{note.appointment_id}"
  end
  
  put '/appointment_notes/:id' do
    redirect '/' unless logged_in_employee
      note = AppointmentNote.find(params[:id])
      note.note = params["note"]
      note.save
      redirect "/appointments/#{note.appointment_id}"
  end