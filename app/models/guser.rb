class Guser < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |guser|
      guser.provider = auth.provider
      guser.uid = auth.uid
      guser.name = auth.info.name
      guser.oauth_token = auth.credentials.token
      guser.oauth_expires_at = Time.at(auth.credentials.expires_at)
      guser.save!
    end
  end
end
