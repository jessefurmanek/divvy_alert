require 'rubygems'
require 'mechanize'
require 'pp'
require '/Users/jessefurmanek/Desktop/DivvyConfig.rb' #password information stored outside git
include DivvyConfig

a = Mechanize.new
a.get('https://www.divvybikes.com/login') do |page|
  # Click the login link
  login_page = a.click(page.link_with(:text => /Member Login/))

  # Submit the login form
  my_page = login_page.form_with(:action => 'https://www.divvybikes.com/login') do |f|
    f.subscriberUsername  = DivvyConfig::User
    f.subscriberPassword  = DivvyConfig::Pass
  end.click_button

  trips_page = a.click(my_page.link_with(:text => /Trips/))

  trips_page.search('tr').each do |tr|
    if tr.search('td').children[2] != nil
      p tr.search('td').children[2].content
    end
  end
end