require 'celluloid'

class Network
  include Celluloid

  def initialize
    @mac_addresses = Set.new
  end

  def connect node
    puts "Adding #{node.mac_address} to network"
    @mac_addresses.add node.mac_address
  end

  def broadcast method, *args
    puts "Broadcasting #{method}(#{args}) to #{@mac_addresses.to_a}"
    responses = @mac_addresses.map do |mac_address|
      Celluloid::Actor[mac_address].send method, *args
    end
    puts "Received responses: #{responses}"
    responses
  end
end
