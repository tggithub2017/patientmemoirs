class RegistrationsController < Devise::RegistrationsController
    private

    def sign_up_params
        params.require(:authcon).permit(:usertype, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:authcon).permit(:usertype, :email, :password, :password_confirmation)
    end
end