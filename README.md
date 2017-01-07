## IP or Country restriction:
A sample Rack app to restrict website from middleware by ip or country

## Dependency:
This Rack app is dependent with geoip gem. So, install geoip gem before start server.

    gem install geoip

## Start server
Run server using following command

    rake firewall.rb
After start server visit http://localhost:8080 from your browser.
