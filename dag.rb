require 'tsort'

class Workflow
  include TSort

  attr_accessor :flow, :state

  def initialize(flow:, state:)
    @flow = flow
    @state = state
  end

  def tsort_each_child(node, &block)
    flow[node].each(&block)
  end

  def tsort_each_node(&block)
    flow.each_key(&block)
  end

  def static_order
    tsort
  end

  def get_ready
    [].tap do |ready_node|
      not_done.each do |node|
        ready_node.push node if get_ready?(node)
      end
    end
  end

  def get_ready?(node)
    each_strongly_connected_component_from(node) do |nodes|
      next if nodes.include? node
      return false if nodes.any? { |n| state[n] == :not_done }
    end
    true
  end

  def done
    static_order.filter { |node| state[node] == :done }
  end

  def not_done
    static_order.filter { |node| state[node] == :not_done }
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

state = {
  ca: :done,
  kr: :done,
  ba: :not_done,
  ua: :not_done,
  qt: :done,
  da: :not_done,
  rc: :not_done,
  rp: :not_done
}

workflow = Workflow.new(flow: flow, state: state)
# p workflow.static_order
# p workflow.done
# p workflow.not_done
# p workflow.get_ready?(:ba)
p workflow.get_ready
