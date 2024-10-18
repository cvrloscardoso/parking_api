class ParkingController < ApplicationController
  def create
    render json: { message: "created" }, status: :ok
  end

  def show
    render json: { message: "showed" }, status: :ok
  end

  def out
    render json: { message: "outed" }, status: :ok
  end

  def pay
    render json: { message: "payed" }, status: :ok
  end
end
