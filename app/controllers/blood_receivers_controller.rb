class BloodReceiversController < ApplicationController
  before_action :signed_in_user # user must be signed in
  before_action :correct_user # signed in user must be current user
  before_action :set_blood_receiver, only: [:show, :edit, :update, :destroy] # call on method to get object
  before_action :guest?, except: [:show, :index, :search] # prevent guests from accessing actions except the listed
  before_action :normal?, only: [:delete] # prevent normal user from deleting



  # GET /blood_receivers
  # GET /blood_receivers.json
  def index
    @blood_receivers = BloodReceiver.order(:id).paginate(page: params[:page], per_page: 5)
  end

  # GET /blood_receivers/1
  # GET /blood_receivers/1.json
  def show
  end

  # GET /blood_receivers/new
  def new
    @blood_receiver = BloodReceiver.new
    @blood_donor = BloodDonor.find(params[:id])
  end

  # GET /blood_receivers/1/edit
  def edit
  end

  # POST /blood_receivers
  # POST /blood_receivers.json
  def create
    @blood_receiver = BloodReceiver.new(blood_receiver_params)
    @blood_donor = BloodDonor.find(@blood_receiver.blood_donor_id)

    respond_to do |format|
      if @blood_receiver.save

        @blood_donor.update(used: TRUE, recipient_id: @blood_receiver.id)


        format.html { redirect_to @blood_receiver, notice: 'Blood receiver was successfully created.' }
        format.json { render :show, status: :created, location: @blood_receiver }
      else
        flash[:error] = 'Error encountered. Refill and try again'
        format.html { redirect_to new_blood_receiver_path(@blood_donor)  }
        format.json { render json: @blood_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blood_receivers/1
  # PATCH/PUT /blood_receivers/1.json
  def update
    respond_to do |format|
      if @blood_receiver.update(blood_receiver_params)
        format.html { redirect_to @blood_receiver, notice: 'Blood receiver was successfully updated.' }
        format.json { render :show, status: :ok, location: @blood_receiver }
      else
        format.html { render :edit }
        format.json { render json: @blood_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blood_receivers/1
  # DELETE /blood_receivers/1.json
  def destroy
    @blood_receiver.destroy
    respond_to do |format|
      format.html { redirect_to blood_receivers_url }
      format.json { head :no_content }
    end
  end

  def search
    @blood_receivers = BloodReceiver.where("name ilike ?", "%#{params[:receiver_name]}%").order(:id).paginate(page: params[:page], per_page: 5)
    render 'index'
  end

  def get_donor
  end

  def show_donor
    @blood_donors = BloodDonor.where("blood_group_id = ? and used = ?", params[:blood_group], FALSE).order(:id).paginate(page: params[:page], per_page: 5)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_receiver
      @blood_receiver = BloodReceiver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blood_receiver_params
      params.require(:blood_receiver).permit(:name, :age, :phone_num, :address, :gender_id, :blood_group_id, :date_received, :blood_donor_id)
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
