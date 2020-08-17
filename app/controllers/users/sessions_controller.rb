# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def destroy
    reset_session
    redirect_to root_path
  end

end
