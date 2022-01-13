class ApplicationController < ActionController::Base
  include SessionsHelper
  include ActionController::Cookies
  protect_from_forgery with: :null_session
end
