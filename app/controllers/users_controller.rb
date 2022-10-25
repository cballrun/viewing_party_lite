class UsersController < ApplicationController

  def register
    # @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
      flash[:success] = "Welcome, #{user.name}"
    else
      redirect_to "/register"
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end
  end

  def login_form
    # render :login_form=
  end

  def login
    def login
      user = User.find_by(name: params[:name])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}!"
        redirect_to root_path
      else
        flash[:error] = "Sorry, your credentials are bad."
        render :login_form
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_parties = @user.user_parties
    @parties = @user_parties.reduce([]) { |array, u_party| array << Party.find(u_party[:party_id]) }
    @movies = @parties.reduce([]) { |array, party| array << MovieFacade.find_movie(party[:movie_id]) }
  end

  def discover
    @user = User.find(params[:id])
  end

  private 
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end


end