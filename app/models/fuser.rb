class Fuser < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |fuser|
      fuser.provider = auth.provider 
      fuser.uid      = auth.uid
      fuser.name     = auth.info.name
      fuser.save
    end
  end
end
