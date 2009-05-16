require File.dirname(__FILE__) + '/../config/environment'

print "Cleaning up any old templates ..."
Facebooker::Rails::Publisher::FacebookTemplate.destroy_all
puts " Done!"
puts

RunPublisher.register_all_templates
puts
puts "Finished registering all templates."

