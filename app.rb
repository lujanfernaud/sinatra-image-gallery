class App < Sinatra::Base
  get "/" do
    haml :index
  end

  post "/images" do
    @image = Image.new params[:image]
    @image.save
    redirect "/"
  end
end