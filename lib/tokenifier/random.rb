module Tokenifier
  class Random
    def self.secret
      Gibberish::SHA256 [Time.now, rand(999999) + 100000].map(&:to_s).join
    end
  end
end