require 'rack'
require 'rack/server'
require 'geoip'

class Firewall
  def self.call(env)
    ip = remote_ip(env)
    country = remote_contry(ip)
    
    if permitted? country
      [200, {}, ['You are most wellcome in our website']]
    else
      [200, {}, ["This website is restricted from #{country[:country_name]}"]]
    end
  end

  def self.permitted?(country)
    country[:country_code3] == 'BGD'
  end

  def self.remote_ip(env)
    fwd = env['HTTP_X_FORWARDED_FOR']
    if fwd
      ip = fwd.strip.split(/[,\s]+/)[0]
    else
      ip = env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR']
    end
    ip
  end

  def self.remote_contry(ip)
    return_hash = {}
    res = GeoIP.new('GeoIP.dat').country ip

    unless res.nil?
      return_hash = Hash[[:country_code3, :country_name, :continent_code].map{ |x| [x, res.__send__(x)] }]
    end
    return_hash
  end
end

Rack::Server.start app: Firewall
