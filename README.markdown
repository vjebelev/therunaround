TheRunAround - The Rails Way
============================

Facebook The Run Around app, done in Rails.

Installation
------------

This assumes we're installing to an Apache Phusion Passenger stack.

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

Facebook Configuration
----------------------

0. Get a publicly available host:
  * dyndns.org
  * static IP

  You can generally get by without a publicly available host with some reduced functionality (FB callbacks won't be working but it's not fatal): just make sure your local settings are configured correctly (/etc/hosts or similar).

1. Add the Developer Application.

2. Create a New Facebook Application.

3. Update the Facebook Application settings to point to your publicly available host. Example settings (lets say your app is hosted at http://run.example.com )

  Authentication Tab. Enter Post-Authorize Callback URL, e.g. http://run.example.com/fb/post_authorize

  Canvas Tab. Enter Canvas Page URL, e.g. run_example_com
              Enter Canvas Callback URL, e.g. http://run.example.com/fb/connect

  Connect Tab. Enter Connect URL, http://run.example.com/fb/connect

  Advanced Tab. Set Application Type as Web.
  

4. Edit the facebooker.yml file to reflect your Facebook Application settings page: set api_key, secret_key, canvas_page_name (copy the last part of the Canvas Page URL from the Canvas tab), callback url (that's Canvas Callback URL from FB settings), and set set_asset_host_to_callback_url to false.


== License

The Run Around app is released under the MIT license.


== Support

Feel free to send bug reports or questions to us at dev@zolou.com . We also provide consulting services to enable Facebook Connect on Rails sites.

