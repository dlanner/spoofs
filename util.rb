# http://www.commandlinefu.com/commands/view/7242/generate-random-valid-mac-addresses
def random_mac_address
  (1..6).map{"%0.2X"%rand(256)}.join(":")
end

# http://stackoverflow.com/a/2808087/2954849
def random_ip_address
  Array.new(4){rand(256)}.join('.')
end
