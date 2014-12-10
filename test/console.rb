require "dbus"
require "pry"

# sessbus = DBus.session_bus
# service = sessbus["ca.thume.transience"]
# obj = service.object "/ca/thume/transience/screensurface"
# obj.introspect
# int = obj["ca.thume.transience.screensurface"]
# puts "Successfully set up!" if int

sessbus = DBus.session_bus
service = sessbus["ca.thume.uiscope"]
obj = service.object "/ca/thume/uiscope/accessibilityproxy"
obj.introspect
int = obj["ca.thume.uiscope.accessibilityproxy"]
puts "Successfully set up!" if int

binding.pry
