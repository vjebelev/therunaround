require File.dirname(__FILE__) + '/../config/environment'

# this script sends all users to fb connect in order to preconnect them, in batches of 1,000

id = 1
window = 1000
max_id = User.maximum :id

while id < max_id
  puts "Processing user ids from #{id}"
  users = User.find(:all, :conditions => ['users.id >= ? and email is not null', id], :limit => window)

  # generate email hash
  users.each do |user|
    user.email_hash
    user.save
  end

  i = 0
  begin
    Facebooker::Session.create.post('facebook.connect.registerUsers', :accounts => users.inject([]) {|ar, user| ar << {:email_hash => user.email_hash, :account_id => user.id}}.to_json)
  rescue 
    i += 1
    retry if i < 3
  end

  id = users.last.id + 1
end
