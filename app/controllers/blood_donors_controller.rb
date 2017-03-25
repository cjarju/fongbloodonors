class BloodDonorsController < ApplicationController
  before_action :signed_in_user # user must be signed in
  before_action :correct_user   # signed in user must be current user
  before_action :set_blood_donor, only: [:show, :edit, :update, :destroy] # call on method to get object
  before_action :guest?, except: [:show, :index, :search] # prevent guests from accessing actions except the listed
  before_action :normal?, only: [:delete] # prevent normal user from deleting



  # GET /blood_donors
  # GET /blood_donors.json
  def index
    @blood_donors = BloodDonor.order(:id).paginate(page: params[:page], per_page: 5)
  end

  # GET /blood_donors/1
  # GET /blood_donors/1.json
  def show
  end

  # GET /blood_donors/new
  def new
    @blood_donor = BloodDonor.new
  end

  # GET /blood_donors/1/edit
  def edit
  end

  # POST /blood_donors
  # POST /blood_donors.json
  def create
    @blood_donor = BloodDonor.new(blood_donor_params)

    name = @blood_donor.name
    age = @blood_donor.age
    gender = @blood_donor.gender_id
    blood_group = @blood_donor.blood_group_id
    date_donated = @blood_donor.date_donated

    @last_donation = BloodDonor.where("name ilike ? and age = ? and gender_id = ? and blood_group_id = ?", name, age, gender, blood_group).order("date_donated desc").first

    nofdays = 91

    if not @last_donation.nil?
      nofdays = date_donated.mjd - @last_donation.date_donated.mjd
    end

    if  nofdays < 91
      calcdays = 90 - nofdays
      flash[:error] = "Existing Donor. Not eligible to donate until #{calcdays} days"
      render action: 'new'
    else
      respond_to do |format|
        if @blood_donor.save
          format.html { redirect_to blood_donor_url(@blood_donor), notice: 'Blood donor was successfully created.' }
          format.json { render action: 'show', status: :created, location: @blood_donor }
        else
          format.html { render action: 'new' }
          format.json { render json: @blood_donor.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /blood_donors/1
  # PATCH/PUT /blood_donors/1.json
  def update
    respond_to do |format|
      if @blood_donor.update(blood_donor_params)
        format.html { redirect_to @blood_donor, notice: 'Blood donor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blood_donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blood_donors/1
  # DELETE /blood_donors/1.json
  def destroy
    @blood_donor.destroy
    respond_to do |format|
      format.html { redirect_to blood_donors_url }
      format.json { head :no_content }
    end
  end

  def search
    @blood_donors = BloodDonor.where("name ilike ?", "%#{params[:donor_name]}%").order(:id).paginate(page: params[:page], per_page: 5)
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_donor
      @blood_donor = BloodDonor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blood_donor_params
      params.require(:blood_donor).permit(:name, :age, :phone_num, :address, :gender_id, :blood_group_id, :date_donated)
    end

    def guest?
      if current_user.user_role.name == 'Guest'
        redirect_to blood_donors_path
      end
    end

    def normal?
      if current_user.user_role.name == 'Normal'
        redirect_to blood_donors_path
      end
    end
end
