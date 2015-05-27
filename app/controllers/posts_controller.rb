class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = []
    if params.key?(:query) && !params[:query].empty?
      PgSearch.multisearch(params[:query]).where(searchable_type: 'Post').find_each do |elem|
        @posts << elem.searchable
      end
    else
      @posts = Post.all
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # tenemos que obtener todos los comentarios de este post y pasarlos a la vista
    @comments = @post.comments.all

    # Creo una instancia de comment para que este disponible en la vista
    # @comment = Comment.new(post:@post)

    # Esto hace lo mismo que lo de arriba pero queda mas clara la relacion
    # entre los modelos
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def upvote
    @post = Post.find(params[:id])
    @vote = @post.votes.build(user: current_user)

    if @post.voted_by? current_user
      @post.votes.where(user: current_user).first.delete
      redirect_to @post, notice: 'Tu voto se ha elimidado :('
    elsif @vote.save
      redirect_to @post, notice: 'Gracias por tu voto :D'
    else
      redirect_to @post, alert: 'Tu voto no se ha guardado :('
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
