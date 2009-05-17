TheRunAround - The Rails Way
============================

Facebook The Run Around app, done in Rails.

Installation
------------

This assume we're installing to an Apache Phusion Passenger stack.

1. Clone the app:

    git clone git://github.com/vjebelev/therunaround.git

2. Edit your Passenger configuration to point to the app, and reload your Apache:

    <VirtualHost *:80>
        DocumentRoot "/opt/code/therunaround/public"
        ServerName trr
        ErrorLog "logs/therunaround-error_log"
        CustomLog "logs/therunaround-access_log" common
        RailsEnv development

        <Directory "/opt/code/therunaround/public">
            Order deny,allow
            Allow from all
        </Directory>
    </VirtualHost>

3. Prepare your database:

    rake db:migrate

4. Run with it!

Facebook Configuration
----------------------

0. Get a publicly available host:
  * dyndns.org
  * static IP

1. Add the Developer Application.

2. Create a New Application.

3. Update the Facebook Application settings to point to your publicly available host.

4. Edit the facebooker.yml file to reflect your Facebook Application settings page.

5. Register the Facebook Post Templates:

    [ed@edbook therunaround (master)]$ ruby bin/register_templates.rb 
    Cleaning up any old templates ... Done!

    Registering new_run

    Finished registering all templates.
    [ed@edbook therunaround (master)]$ 

