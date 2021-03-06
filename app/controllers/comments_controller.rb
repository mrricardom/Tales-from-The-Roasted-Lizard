class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create, :update, :destroy]
  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  # def create
  #   @comment = Comment.new(comment_params)

  #   if @comment.save
  #     render json: @comment, status: :created
  #   else
  #     render json: @comment.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    @posting = Posting.find(params[:posting_id])
    @comment = @posting.comments.create(comment_params)
    if @comment.save
       render json: @comment, status: :created
        else
        render json: @comment.errors, status: :unprocessable_entity
    end  
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content, :img_url).merge(user_id: @current_user.id)
    end
end
