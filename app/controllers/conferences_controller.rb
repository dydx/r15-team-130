class ConferencesController < ApplicationController
  before_action :set_conference, only: [:show, :edit, :update, :destroy]

  # GET /conferences
  # GET /conferences.json
  def index
    @conferences = Conference.all
  end

  # GET /conferences/1
  # GET /conferences/1.json
  def show
    @locations = Gmaps4rails.build_markers(@conference) do |conference, marker|
      marker.lat conference.latitude
      marker.lng conference.longitude
      marker.title conference.name
    end
    @client ||= ::GooglePlaces::Client.new(ENV['GOOGLE_PLACES'])
    @restaurants ||= @client.spots(@conference.latitude, @conference.longitude, :types => ['restaurant', 'food'])
    @hotels ||= @client.spots(@conference.latitude, @conference.longitude, :types => ['lodging', 'rv_park', 'park'])
    @transportation ||= @client.spots(@conference.latitude, @conference.longitude, :types => ['subway_station', 'bus_station', 'car_rental', 'train_station', 'taxi_stand', 'travel_agency'])
    @funstuff ||= @client.spots(@conference.latitude, @conference.longitude, :types => ['amusement_park', 'library', 'liquor_store', 'book_store', 'bar', 'museum', 'casino', 'night_club', 'dentist'])
  end

  # GET /conferences/new
  def new
    @conference = Conference.new
  end

  # GET /conferences/1/edit
  def edit
  end

  # POST /conferences
  # POST /conferences.json
  def create
    @conference = Conference.new(conference_params)

    respond_to do |format|
      if @conference.save
        format.html { redirect_to @conference, notice: 'Conference was successfully created.' }
        format.json { render :show, status: :created, location: @conference }
      else
        format.html { render :new }
        format.json { render json: @conference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conferences/1
  # PATCH/PUT /conferences/1.json
  def update
    respond_to do |format|
      if @conference.update(conference_params)
        format.html { redirect_to @conference, notice: 'Conference was successfully updated.' }
        format.json { render :show, status: :ok, location: @conference }
      else
        format.html { render :edit }
        format.json { render json: @conference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conferences/1
  # DELETE /conferences/1.json
  def destroy
    @conference.destroy
    respond_to do |format|
      format.html { redirect_to conferences_url, notice: 'Conference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conference
      @conference = Conference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conference_params
      params.require(:conference).permit(:name, :dateandtime, :description, :address, :longitude, :latitude)
    end
end
