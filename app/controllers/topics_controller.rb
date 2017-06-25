class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:edit, :update, :destroy, :show]

  def index
    @topics = Topic.all.reverse_order
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "Topicを作成しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @topic.update(topics_params)
    redirect_to topics_path, notice: "Topicを編集しました！"
  else
    render 'edit'
  end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "Topicを削除しました！"
  end

  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end


  private
    def topics_params
      params.require(:topic).permit(:title, :content, :update)
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end
