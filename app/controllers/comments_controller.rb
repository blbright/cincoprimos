class CommentsController < ApplicationController
  def new
    @reservation = Reservation.find(params[:reservation_id])
    @comment = Comment.new

  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @comment = @reservation.comments.create(comment_params)


    @comment.content = params[:comment][:content]
    #@comment.reservation = @reservation
    @comment.save

    redirect_to reservation_path(@reservation)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :reservation_id)
  end
end
