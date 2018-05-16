require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get '/' do
  @files = Dir.foreach('public').reject { |f| File.extname(f).empty? }.sort
  @files = @files.reverse if params[:sort] == "descend"
  
  erb :home
end
