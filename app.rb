require 'dotenv'
Dotenv.load

set :public_dir, Proc.new { File.join(root, "_site") }
set :views, Proc.new { File.join(File.dirname(__FILE__), "views") }

before do
  response.headers['Cache-Control'] = 'public, max-age=36000'
end

get %r{(/.*)\/$} do
  redirect "#{params[:captures].first}"
end

get '/' do
  erb :index
end

post '/contact', provides: :json do
  puts params
end

get '/blog' do
  File.read("_site/index.html")
end

get '/blog/:title' do
  file_name = "_site#{request.path_info}/index.html".gsub(%r{\/+},'/')
  if File.exists?(file_name)
    File.read(file_name)
  else
    raise Sinatra::NotFound
  end
end