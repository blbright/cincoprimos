class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @reservation = Reservation.find(params[:reservation_id])
  end

  def create
    @comment = Comment.new
    @reservation = Reservation.find(params[:reservation_id])

    @comment.content = params[:comment][:content]
    #@comment.reservation = @reservation
    @comment.save

    redirect_to reservation_path(@reservation)
  end
end
