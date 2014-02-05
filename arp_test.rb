require './network.rb'
require './arp_client.rb'
require './util.rb'

Celluloid::Actor["network"] = Network.new

[ "Alice", "Bob", "Eve" ].map do |hostname|
  ArpClient.new hostname, random_mac_address, random_ip_address
end

alice = Celluloid::Actor["Alice"]
bob = Celluloid::Actor["Bob"]
eve = Celluloid::Actor["Eve"]

# Alice and Bob store each other's MAC/IP addresses in their routing tables
alice.resolve_ip_address bob.ip_address
bob.resolve_ip_address alice.ip_address
p alice
p bob
p eve

# Eve pretends to be Alice to Bob and Bob to Alice
eve.mitm alice, bob
p alice
p bob
