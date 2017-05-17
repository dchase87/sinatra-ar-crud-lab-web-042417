require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(name: params['name'], content: params['content'])
    erb :index
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    post_id = params[:id].to_i
      if Post.pluck(:id).include?(post_id)
        @post = Post.find(params[:id])
        erb :show
      else
        redirect '/'
      end
    end

  get '/posts/:id/edit' do
    post_id = params[:id].to_i
      if Post.pluck(:id).include?(post_id)
        @post = Post.find(params[:id])
        erb :edit
      else
        redirect '/posts/:id'
      end
    end

  post "/posts/:id" do
    @post = Post.find(params[:id])
    @post.update(name: params["name"], content: params["content"])
    @post.save
    redirect "/posts/#{@post.id}"
  end

  post "/posts/:id/delete" do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end

end
