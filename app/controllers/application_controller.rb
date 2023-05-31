class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scop)
    if resource_or_scop.is_a?(Admin)

       admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scop)
    if resource_or_scop == :admin
      admin_session_path
    else root_path

    end
  end


  def configure_permitted_parameters
    #binding.pry
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :part, :birthday, :sex, :experience, :image])
  end

end
