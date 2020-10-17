require 'rgl/adjacency'
# Use DOT to visualize this graph:
require 'rgl/dot'

flow = {
  ca: [],
  kr: [:ca],
  ba: [:kr],
  ua: [:ca],
  qt: [:ua],
  da: [:ba, :ua],
  rc: [:da],
  rp: [:qt, :rc]
}

dg = RGL::DirectedAdjacencyGraph[]

flow.each do |child, parents|
  parents.each { |parent| dg.add_edge parent, child } if parents.length > 0
end

dg.write_to_graphic_file('png')
