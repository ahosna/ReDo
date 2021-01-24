class RotationsController < ApplicationController
  before_action :set_rotation, only: [:show, :edit, :update, :destroy]

  # GET /rotations
  # GET /rotations.json
  def index
    @rotations = Rotation.all
  end

  # GET /rotations/1
  # GET /rotations/1.json
  def show
  end

  # GET /rotations/new
  def new
    @rotation = Rotation.new
  end

  # GET /rotations/1/edit
  def edit
  end

  # POST /rotations
  # POST /rotations.json
  def create
    @rotation = Rotation.new(rotation_params)

    respond_to do |format|
      if @rotation.save
        format.html { redirect_to @rotation, notice: 'Rotation was successfully created.' }
        format.json { render :show, status: :created, location: @rotation }
      else
        format.html { render :new }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rotations/1
  # PATCH/PUT /rotations/1.json
  def update
    respond_to do |format|
      if @rotation.update(rotation_params)
        format.html { redirect_to @rotation, notice: 'Rotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @rotation }
      else
        format.html { render :edit }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotations/1
  # DELETE /rotations/1.json
  def destroy
    @rotation.destroy
    respond_to do |format|
      format.html { redirect_to rotations_url, notice: 'Rotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rotation
      @rotation = Rotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rotation_params
      params.require(:rotation).permit(:face, :redo_id)
    end
end
