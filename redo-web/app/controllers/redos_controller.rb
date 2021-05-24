class RedosController < ApplicationController
  before_action :set_redo, only: [:show, :edit, :update, :destroy]

  # GET /redos
  # GET /redos.json
  def index
    @redos = Redo.all
  end

  # GET /redos/1
  # GET /redos/1.json
  def show
  end

  # GET /redos/new
  def new
    @redo = Redo.new
  end

  # GET /redos/1/edit
  def edit
  end

  # POST /redos
  # POST /redos.json
  def create
    @redo = Redo.new(redo_params)

    respond_to do |format|
      if @redo.save
        format.html { redirect_to @redo, notice: 'Redo was successfully created.' }
        format.json { render :show, status: :created, location: @redo }
      else
        format.html { render :new }
        format.json { render json: @redo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redos/1
  # PATCH/PUT /redos/1.json
  def update
    respond_to do |format|
      if @redo.update(redo_params)
        format.html { redirect_to @redo, notice: 'Redo was successfully updated.' }
        format.json { render :show, status: :ok, location: @redo }
      else
        format.html { render :edit }
        format.json { render json: @redo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redos/1
  # DELETE /redos/1.json
  def destroy
    @redo.destroy
    respond_to do |format|
      format.html { redirect_to redos_url, notice: 'Redo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redo
      @redo = Redo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def redo_params
      params.require(:redo).permit(:type, :version, :key)
    end
end
