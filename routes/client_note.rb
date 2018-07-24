get '/client_note/:id' do
  if logged_in_employee
    @note = ClientNote.find(params[:id])
  elsif session[:client_id] == ClientNote.find(params[:id]).client_id
    @note = ClientNote.find(params[:id])
  else
    redirect '/'
  end
end

get '/client_notes' do
  if logged_in_employee
    @notes = ClientNote.where(active: true)
  else
    redirect '/'
  end
end

post '/client_note' do
  if logged_in_employee
    note = ClientNote.new(
      note: params["note"],
      active: true,
      client_id: params["client-id"],
      last_update: Time.now,
      date_created: Time.now
    )
    note.save
    redirect "/clients/#{params["client-id"]}"
  else
    redirect '/'
  end
end

get '/client_notes/:id/edit' do
  if logged_in_employee
    @note = ClientNote.find(params[:id])
    erb :"client_notes/edit", layout: :'layouts/admin'
  else
    redirect '/'
  end
end

put '/client_notes/:id/deactivate' do
  if logged_in_employee
    note = ClientNote.find(params[:id])
    note.active = false
    note.save
    redirect "/clients/#{note.client_id}"
  else
    redirect '/'
  end
end

put '/client_notes/:id' do
  if logged_in_employee
    note = ClientNote.find(params[:id])
    note.note = params["note"]
    note.save
    redirect "/clients/#{note.client_id}"
  else
    redirect '/'
  end
end