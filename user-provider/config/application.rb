require 'cynic'
Dir.glob(["./app/**/*.rb"]).each {|file| require file }

module UserProvider
  class Application < Cynic::App
    # Your code here
  end
end
