require 'celluloid'

class ArpClient
  include Celluloid

  attr_accessor :name, :mac_address, :ip_address

  def initialize name, mac_address, ip_address
    @name = name
    @mac_address = mac_address
    @ip_address = ip_address
    @mac_ip_associations = {}
    associate mac_address, ip_address
    Celluloid::Actor[name] = Celluloid::Actor[mac_address] = Actor.current
    Celluloid::Actor["network"].connect Actor.current
  end

  def who_has_ip? ip_address
    @mac_address if @ip_address == ip_address
  end

  def resolve_ip_address ip_address
    mac_address = Celluloid::Actor["network"].broadcast(:who_has_ip?, ip_address).select{|x|x}.first
    associate mac_address, ip_address
  end

  def associate mac_address, ip_address
    @mac_ip_associations[ip_address] = mac_address
  end

  def mitm node1, node2
    node1.associate @mac_address, node2.ip_address
    node2.associate @mac_address, node1.ip_address
  end
end