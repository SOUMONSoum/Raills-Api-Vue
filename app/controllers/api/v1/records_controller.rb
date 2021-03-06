module Api
  class V1::RecordsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_access_request!
    before_action :set_record, only: [:show, :edit, :update, :destroy]

    # GET /records
    def index
      @records = current_user.records.all

      render json: @records
    end

    def show
      render json: @record
    end

    # POST /records
    def create
      @record = current_user.records.build(record_params)

      if @record.save
        render json: @record, status: :created
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /records/1
    def update
      if @record.update(record_params)
        render json: @record
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end

    # DELETE /records/1
    def destroy
      @record.destroy
    end

    private
    
      def set_record
        @record = current_user.records.find(params[:id])
      end

      def record_params
        params.require(:record).permit(:title, :year, :artist_id)
      end
  end
end
