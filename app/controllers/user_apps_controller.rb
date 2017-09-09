class UserAppsController < ApplicationController
  before_action :set_user_app, only: [:show, :edit, :update, :destroy]

  # GET /user_apps
  # GET /user_apps.json
  def index
    @user_apps = UserApp.all
  end

  # GET /user_apps/1
  # GET /user_apps/1.json
  def show
  end

  # GET /user_apps/new
  def new
    @user_app = UserApp.new
  end

  # GET /user_apps/1/edit
  def edit
  end

  # POST /user_apps
  # POST /user_apps.json
  def create
    @user_app = UserApp.where("email = '" + params[:user_app][:email] +"'")
    if(@user_app[0] == nil) 
        @user_app = UserApp.new(user_app_params)

        respond_to do |format|
          if @user_app.save
            format.html { redirect_to @user_app, notice: 'successfully registered.' }
            format.json { render :show, status: :created, location: @user_app }
          else
            format.html { render :new }
            format.json { render json: @user_app.errors, status: :unprocessable_entity }
          end
         end
    else
       @user_app = UserApp.new
       redirect_to new_user_app_path , notice: 'This email is already registered!'
    end
  end

  # PATCH/PUT /user_apps/1
  # PATCH/PUT /user_apps/1.json
  def update
    respond_to do |format|
      if @user_app.update(user_app_params)
        format.html { redirect_to @user_app, notice: 'User app was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_app }
      else
        format.html { render :edit }
        format.json { render json: @user_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_apps/1
  # DELETE /user_apps/1.json
  def destroy
    @user_app = UserApp.find(params[:id])
    @user_app.destroy
    respond_to do |format|
      format.html { redirect_to user_apps_url, notice: 'User app was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_app
      @user_app = UserApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_app_params
      params.require(:user_app).permit(:name, :email, :password, :password_confirmation ,:password_digest, :ppic)
    end
end
