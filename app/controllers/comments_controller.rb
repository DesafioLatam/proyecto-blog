class CommentsController < ApplicationController

  # metodo que se va a llamar cuando hacemos submit en el formulario que esta en el show del post
  def create
    # Obtener el post
    @post = Post.find(params[:post_id])
    # Ahora vamos a construir el comentario
    @comment = @post.comments.build(comments_params)

    # antes de guardar tenemos que obtener todos los comentarios del post para que
    # este disponible cuando hacemos el render
    @comments = @post.comments.all

    # Ahora vamos a guardar el comentario en la base de datos
    if @comment.save
      redirect_to @post, notice: 'El comentario se guardo con éxito :)'
    else
      render 'posts/show'
    end
  end

  private
    # proteccion antes de crear el objeto para evitar injeccion de datos,
    # solo permitir los siguientes
    def comments_params
      params.require(:comment).permit(:author, :content)
    end
end
