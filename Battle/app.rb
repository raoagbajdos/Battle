require 'sinatra/base'

class Battle < Sinatra::Base
  enable :sessions

get '/' do
  erb :index
end

post '/names' do
  session[:player_1_name] = params[:player_1_name]
  session[:player_2_name] = params[:player_2_name]
  redirect '/play'
end

get '/play' do
  @player_1_name = session[:player_1_name]
  @player_2_name = session[:player_2_name]
  erb :play
end

post '/names' do
  erb :play
end

get '/attack' do
    @player_1_name = session[:player_1_name]
    @player_2_name = session[:player_2_name]
  erb :attack
end

run! if app_file == $0
end

post '/names' do
  $player_1 = Player.new(params[:player_1_name])
  $player_2 = Player.new(params[:player_2_name])
  redirect '/play'
end

get '/play' do
  @player_1_name = $player_1.name
  @player_2_name = $player_2.name
  erb :play
end

get '/attack' do
  @player_1 = $player_1
  @player_2 = $player_2
  @player_1.attack(@player_2)
  erb :attack
end
