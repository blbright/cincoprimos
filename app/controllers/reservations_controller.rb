class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]


  # GET /reservations
  # GET /reservations.json
  def index
    #pretty sure i dont need this as there is no index page for reservations
    #@reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])
    @comment = Comment.new
    @comments = @reservation.comments
    #@user = @comment.user.name
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.start_date < Date.today
      flash[:notice] = 'Reservation failed. Start date must be after Today.'
      render :new
    elsif @reservation.end_date < @reservation.start_date
      flash[:notice] = 'Reservation failed. End date must come after start date!'
      render :new
    elsif Reservation.exists?(start_date: @reservation.start_date..@reservation.end_date)
      flash[:notice] = 'Reservation failed. Someone has already reserved this date!'
      render :new
    elsif Reservation.exists?(end_date: @reservation.start_date..@reservation.end_date)
      flash[:notice] = 'Reservation failed. Someone has already reserved this date!'
      render :new
    else
      @reservation.save
      redirect_to @reservation, notice: 'Reservation was successfully created.'
    end

  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to checkins_path, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :user_id)
    end


end
