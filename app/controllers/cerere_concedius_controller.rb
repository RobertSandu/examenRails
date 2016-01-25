class CerereConcediusController < ApplicationController
  before_action :set_cerere_concediu, only: [:show, :edit, :update, :destroy]

  # GET /cerere_concedius
  # GET /cerere_concedius.json
  def index
    @cerere_concedius = CerereConcediu.all

    if current_user.tip_utilizator == 0
      @cerere_concedius = current_user.cerere_concediu.all
    end
  end

  # GET /cerere_concedius/1
  # GET /cerere_concedius/1.json
  def show
  end

  # GET /cerere_concedius/new
  def new
    @cerere_concediu = CerereConcediu.new
  end

  # GET /cerere_concedius/1/edit
  def edit
  end

  # POST /cerere_concedius
  # POST /cerere_concedius.json
  def create
    @cerere_concediu = CerereConcediu.new(cerere_concediu_params)

    @cerere_concediu.user_id = current_user.id

    business_days = 0
    date = @cerere_concediu.data_sfarsit
    while date > @cerere_concediu.data_inceput
     business_days = business_days + 1 unless date.saturday? or date.sunday?
     date = date - 1.day
    end

    if business_days <= 5
        @cerere_concediu.aprobata = 1
        current_user.zile_concediu = current_user.zile_concediu - business_days
        current_user.save
    else
        @cerere_concediu.aprobata = 0
    end


    

    respond_to do |format|
      if @cerere_concediu.save
        format.html { redirect_to @cerere_concediu, notice: 'Cerere concediu was successfully created.' }
        format.json { render :show, status: :created, location: @cerere_concediu }
      else
        format.html { render :new }
        format.json { render json: @cerere_concediu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cerere_concedius/1
  # PATCH/PUT /cerere_concedius/1.json
  def update
    respond_to do |format|
      if @cerere_concediu.update(cerere_concediu_params)
        format.html { redirect_to @cerere_concediu, notice: 'Cerere concediu was successfully updated.' }
        format.json { render :show, status: :ok, location: @cerere_concediu }
      else
        format.html { render :edit }
        format.json { render json: @cerere_concediu.errors, status: :unprocessable_entity }
      end
    end
  end

  def aproba

    @cerere_concediu = CerereConcediu.find_by_id(params[:id])

    #@exista_cereri = CerereConcediu.find(:conditions=>["data_inceput >=? and data_sfarsit=? and user_id=?"
      #, @cerere_concediu.data_inceput
      #, @cerere_concediu.data_sfarsit
      #, @cerere_concediu.user_id]).count(:user_id)

    #if @exista_cereri > 0
      #flash[:notice] = 'exista deja o cerere asemanatoare aprobata'
    #else

      business_days = 0
      date = @cerere_concediu.data_sfarsit
      while date > @cerere_concediu.data_inceput
       business_days = business_days + 1 unless date.saturday? or date.sunday?
       date = date - 1.day
      end
      
      @utilizator = User.find_by_id(@cerere_concediu.user_id)

      if @utilizator.zile_concediu >= business_days

        @cerere_concediu.aprobata = 1

        

        @utilizator.zile_concediu = @utilizator.zile_concediu - business_days

        @cerere_concediu.save

        @utilizator.save
        flash[:notice] = 'Cererea a fost aprobata'
      else
        flash[:notice] = 'Cererea nu a fost aprobata'
      end
    #end

    redirect_to @cerere_concediu

  end

  # DELETE /cerere_concedius/1
  # DELETE /cerere_concedius/1.json
  def destroy
    @cerere_concediu.destroy
    respond_to do |format|
      format.html { redirect_to cerere_concedius_url, notice: 'Cerere concediu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cerere_concediu
      @cerere_concediu = CerereConcediu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cerere_concediu_params
      params.require(:cerere_concediu).permit(:data_inceput, :data_sfarsit)
    end
end
