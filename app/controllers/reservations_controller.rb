class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = current_user.reservations.build
  end

  def show
  end

  def edit
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      ReservationMailer.reservation_mail(@reservation).deliver  ##追記
      redirect_to reservations_path, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: 'イベントを削除しました'
  end

  private
  def set_reservation
    @reservation = Reservation.find(params[:id,])
  end
  def reservation_params
    params.require(:reservation).permit(:date, :ticket_type, :number_of_ticket, :total_price, :remarks, :cast_name)
  end
end
