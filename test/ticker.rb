require "dbus"

sessbus = DBus.session_bus
service = sessbus["ca.thume.uiscope"]
obj = service.object "/ca/thume/uiscope/accessibilityproxy"
obj.introspect
int = obj["ca.thume.uiscope.accessibilityproxy"]
puts "Successfully set up!" if int

loop do
  int.update
  puts "tick"
  sleep 3
end
