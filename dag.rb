require 'tsort'

class Workflow
  include TSort

  attr_accessor :flow, :state

  def initialize(flow:, state:)
    @flow = flow
    @state = state
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
      return false if nodes.any? { |n| !state["#{n}_done?".to_sym].call }
    end
    true
  end

  def done
    static_order.filter { |node| state["#{node}_done?".to_sym].call }
  end

  def not_done
    static_order.filter { |node| !state["#{node}_done?".to_sym].call }
  end

  private

  def tsort_each_child(node, &block)
    flow[node].each(&block)
  end

  def tsort_each_node(&block)
    flow.each_key(&block)
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
  ca_done?: -> { true },
  kr_done?: -> { true },
  ba_done?: -> { false },
  ua_done?: -> { false },
  qt_done?: -> { false },
  da_done?: -> { false },
  rc_done?: -> { false },
  rp_done?: -> { false },
}

workflow = Workflow.new(flow: flow, state: state)
# p workflow.static_order
# p workflow.done
# p workflow.not_done
# p workflow.get_ready?(:ba)
p workflow.get_ready
