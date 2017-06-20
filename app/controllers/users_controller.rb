class UsersController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource

  def index
    if current_user.role ==  "Admin"
      @users = User.all
    else
      @user = User.find(current_user.id)
   end
    redirect_to new_user_registration_path if current_user.nil?
    respond_to do |format|
      format.html
    end
  end

   def show
     @user = User.find(params[:id])
     respond_to do |format|
        format.html
     end
   end

   def new
    @user = User.new
   end

   def create
    @user = User.new(user_params)
    @user.role = 'Non-admin'

   if @user.save
      redirect_to :action => 'index'
   else
      render :action => 'new'
   end
   end

   def user_params
      params.require(:user).permit(:first_name, :last_name, :age, :biography, :email)
   end

   def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
   end

   def update
    params.inspect
    @user = User.find(params[:id])

   if @user.update_attributes(user_params)
      redirect_to :action => 'show', :id => @user
   else
      render :action => 'edit'
   end
   end

   def delete
    User.find(params[:id]).destroy
   redirect_to :action => 'index'
   end

end
