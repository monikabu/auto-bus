class Trips::Base
  def self.get(url)
    Excon.get url
  end
end
