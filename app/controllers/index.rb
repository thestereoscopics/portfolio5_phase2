enable :sessions

get '/' do
  session[:errors] = []
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :events_new
end

post '/events/create' do
  @event = Event.new(organizer_name: params[:event][:name],
               organizer_email: params[:event][:email],
               title: params[:event][:title],
               date: params[:event][:date])
  @event.valid?
  
  @title = @event.errors.messages[:title].join("") if @event.errors.messages[:title]
  @date = @event.errors.messages[:date].join("") if @event.errors.messages[:date]

  if @event.valid?
    @event.save
    redirect '/'
  else
    erb :events_new
  end
end

