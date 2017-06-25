class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.js { render :index }
        unless @comment.topic.user_id == current_user.id
        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したtopicにコメントが付きました'
        })
      end
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @comment  = Comment.find(params[:id])
    render '_edit_comment'
  end

  def update
    @comment.update(comments_params)
    redirect_to topics_path, notice: "コメントを編集しました！"
  end



  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
       flash[:notice] = 'コメントを削除しました。'
       respond_to do |format|
        format.js { render :index }
      end
  end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
  end
