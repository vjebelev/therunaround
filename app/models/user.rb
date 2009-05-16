class User < ActiveRecord::Base
  has_many :runs

  validates_uniqueness_of :username, :email

  def is_facebook_user?
    fb_uid > 0
  end

  def miles
    runs.to_a.sum(&:miles)
  end

  def email=(email)
    self.email_hash = build_email_hash(email)
    write_attribute(:email, email)
  end

  def register_with_facebook
    Facebooker::Session.create.post('facebook.connect.registerUsers', :accounts => [{:email_hash => email_hash, :account_id => id}].to_json)
  end

  def before_save
    # re-register with facebook if email address changed
    if !new_record? && email_changed?
      register_with_facebook
    end
  end

  def after_create
    # register with facebook when a new user record is created
    register_with_facebook
  end

  private
  def build_email_hash(email)
    str = email.strip.downcase
    "#{Zlib.crc32(str)}_#{Digest::MD5.hexdigest(str)}"
  end
end
