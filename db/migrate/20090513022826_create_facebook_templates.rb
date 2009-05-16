class CreateFacebookTemplates < ActiveRecord::Migration
  def self.up
    create_table :facebook_templates, :force => true do |t|
      t.string :template_name, :null => false
      t.string :content_hash, :null => false
      t.string :bundle_id, :null => true
    end
    add_index :facebook_templates, :template_name, :unique => true

    print "Cleaning up any old templates ..."
    Facebooker::Rails::Publisher::FacebookTemplate.destroy_all
    puts " Done!"

    RunPublisher.register_all_templates
    puts "\nFinished registering all templates."
  end

  def self.down
    drop_table :facebook_templates
  end
end
