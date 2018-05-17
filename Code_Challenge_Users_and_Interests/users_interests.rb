require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @users = Psych.load_file('data/users.yaml')
  @usernames = @users.keys
end

helpers do
  def count_interests
    @usernames.inject(0) do |acc, name|
      acc + @users[name][:interests].size
    end
  end
end

get '/' do
  erb :home
end

get '/user/:name' do
  @user_sym = params[:name].to_sym
  @current_user = @users[@user_sym]
  redirect '/' if @current_user.nil?

  erb :users
end

not_found do
  redirect '/'
end
