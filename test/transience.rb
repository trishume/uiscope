require "dbus"
require "pry"

def rect_to_dot(r)
  pt = [r[0]+r[2]/2,r[1]+r[3]/2]
  pt + [rand(250),rand(250),rand(250)]
end

sessbus = DBus.session_bus
transience = sessbus["ca.thume.transience"]
screen = transience.object "/ca/thume/transience/screensurface"
screen.introspect
screen.default_iface = "ca.thume.transience.screensurface"
puts "Successfully set up transience!" if screen

uiscope = sessbus["ca.thume.uiscope"]
proxy = uiscope.object "/ca/thume/uiscope/accessibilityproxy"
proxy.introspect
proxy.default_iface = "ca.thume.uiscope.accessibilityproxy"
puts "Successfully set up uiscope!" if proxy

proxy.on_signal("newRects") do |rects|
  dots = rects.map { |r| rect_to_dot(r) }
  screen.doFrame(dots)
  puts "frame with #{dots.length} dots"
end

# binding.pry

main = DBus::Main.new
main << sessbus
main.run
