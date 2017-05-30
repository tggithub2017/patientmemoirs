OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1336834446365119', '94d0e85a45d35cb80ac6848644a8bf9a', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
  provider :google_oauth2, '211022587232-d1h73nktpoo20qa1kdo6n2bmnbis0dkb.apps.googleusercontent.com', 's6kwRnizzE77_C0L--BeCH1h', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end