class UsersController < ApplicationController

  def index
    @users = User.all
    redirect_to new_user_registration_path if current_user.nil?
    respond_to do |format|
      format.html
    end
  end

   def show
    if (User.all.pluck(:id).include?params[:id].to_i) == false
      flash[:notice] = "You cannot perform such an action"
    else
     @user = User.find(params[:id])
   end
     respond_to do |format|
        format.html
     end
   end

   def new
    @user = User.new
   end

   def create
    @user = User.new(user_params)

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
    if (User.all.pluck(:id).include?params[:id].to_i) == false
      flash[:notice] = "You cannot perform such an action"
    else
    @user = User.find(params[:id])
    end
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
