class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  # metodo que se va a llamar cuando hacemos submit en el formulario que esta en el show del post
  def create
    # Obtener el post
    @post = Post.find(params[:post_id])
    # Ahora vamos a construir el comentario
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    # antes de guardar tenemos que obtener todos los comentarios del post para que
    # este disponible cuando hacemos el render
    @comments = @post.comments.all

    # Ahora vamos a guardar el comentario en la base de datos
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comentario creado'}
        format.js
      else
        format.html { render 'posts/show'}
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id]).destroy

    redirect_to @post
  end

  def upvote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.build(user: current_user)

    if @comment.voted_by? current_user
      @comment.votes.where(user: current_user).first.delete
      redirect_to @post, notice: 'Tu voto se ha elimidado :('
    elsif @vote.save
      redirect_to @post, notice: 'Gracias por tu voto :D'
    else
      redirect_to @post, alert: 'Tu voto no se ha guardado :('
    end
  end

  private
    # proteccion antes de crear el objeto para evitar injeccion de datos,
    # solo permitir los siguientes
    def comment_params
      params.require(:comment).permit(:content)
    end
end
