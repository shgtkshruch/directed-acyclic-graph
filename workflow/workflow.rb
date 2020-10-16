require 'tsort'

class Workflow
  include TSort

  def initialize(item)
    @item = item
  end

  def flow
    raise NotImplementedError, "#{self.class.name} must imprement `flow` method"
  end

  def static_order
    tsort
  end

  def get_ready
    not_done.filter(&method(:get_ready?))
  end

  def get_ready?(node)
    each_strongly_connected_component_from(node) do |nodes|
      next if nodes.include? node
      # TODO: return reason why this node is not ready
      return false if !nodes.all?(&method(:done?))
    end
    true
  end

  def done
    static_order.filter(&method(:done?))
  end

  def not_done
    static_order - done
  end

  def valid?
    static_order.all? do |node|
      each_strongly_connected_component_from(node) do |nodes|
        return done?(node) && nodes.all?(&method(:done?))
      end
    end
  end

  def invalid?
    !valid?
  end

  private

  attr_reader :item

  def tsort_each_child(node, &block)
    flow[node].each(&block)
  end

  def tsort_each_node(&block)
    flow.each_key(&block)
  end

  def done?(node)
    self.send("#{node}_done?")
  end
end
