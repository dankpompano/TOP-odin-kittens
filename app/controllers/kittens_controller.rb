class KittensController < ApplicationController
  before_action :set_kitten, only: %i[ show edit update destroy ]

  # GET /kittens or /kittens.json
  def index
    @kittens = Kitten.all
  end

  # GET /kittens/1 or /kittens/1.json
  def show
    @kitten = Kitten.find(params[:id])
  end

  # GET /kittens/new
  def new
    @kitten = Kitten.new
  end

  # GET /kittens/1/edit
  def edit
    @kitten = Kitten.find(params[:id])
    
    respond_to do |format|
      if @kitten.edit
        format.html { redirect_to @kitten, notice: "Kitten was successfully created." }
        format.json { render :show, status: :created, location: @kitten }
        flash[:success] = @kitten.success.full_messages
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @kitten.errors, status: :unprocessable_content }
        flash[:errors] = @kitten.errors.full_messages
      end
    end
  end

  # POST /kittens or /kittens.json
  def create
    @kitten = Kitten.new(kitten_params)

    respond_to do |format|
      if @kitten.save
        format.html { redirect_to @kitten, notice: "Kitten was successfully created." }
        format.json { render :show, status: :created, location: @kitten }
        flash[:success] = @kitten.success.full_messages
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @kitten.errors, status: :unprocessable_content }
        flash[:errors] = @kitten.errors.full_messages
      end
    end
  end

  # PATCH/PUT /kittens/1 or /kittens/1.json
  def update
    respond_to do |format|
      if @kitten.update(kitten_params)
        format.html { redirect_to @kitten, notice: "Kitten was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @kitten }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @kitten.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /kittens/1 or /kittens/1.json
  def destroy
    @kitten.destroy!

    respond_to do |format|
      format.html { redirect_to kittens_path, notice: "Kitten was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kitten
      @kitten = Kitten.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def kitten_params
      params.fetch(:kitten, {})
    end
end
