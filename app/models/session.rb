class Session < ApplicationRecord
  self.primary_key = :session_id

  serialize :data

  def self.new_id
    SecureRandom.urlsafe_base64
  end

  def encrypt(id)
    Digest::SHA256.hexdigest(id)
  end
end
