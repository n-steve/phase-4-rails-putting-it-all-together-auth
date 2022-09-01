class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
before_action :authorization_status
before_action :authenticate_user

private

def authorization_status
  return render json:  { errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
end 

def render_unprocessable_entity(exception)
  render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity
end

def authenticate_user
  @user ||= session[:user_id] && User.find_by(id: session[:user_id])
end

end
