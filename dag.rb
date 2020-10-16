require 'tsort'

class Workflow
  include TSort

  attr_accessor :flow

  def initialize(flow:)
    @flow = flow
  end

  def tsort_each_child(node)
    flow[node].each do |child|
      yield child
    end
  end

  def tsort_each_node
    flow.each_key do |node|
      yield node
    end
  end

  def static_order
    each_strongly_connected_component do |node|
      p node
    end
  end
end

flow = {
  ca: [],
  kr: [:ca],
  ba: [:kr],
  ua: [:ca],
  qt: [:ua],
  da: [
    :ba,
    :ua
  ],
  rc: [:da],
  rp: [:rc]
}

Workflow.new(flow: flow).static_order
