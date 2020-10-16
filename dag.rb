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
    [].tap do |ready_node|
      not_done.each do |node|
        ready_node.push node if get_ready?(node)
      end
    end
  end

  def get_ready?(node)
    each_strongly_connected_component_from(node) do |nodes|
      next if nodes.include? node
      return false if nodes.any? { |n| !self.send("#{n}_done?") }
    end
    true
  end

  def done
    static_order.filter { |node| self.send("#{node}_done?") }
  end

  def not_done
    static_order.filter { |node| !self.send("#{node}_done?") }
  end

  private

  attr_reader :item

  def tsort_each_child(node, &block)
    flow[node].each(&block)
  end

  def tsort_each_node(&block)
    flow.each_key(&block)
  end
end

class ProFlow < Workflow
  def flow
    {
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
  end

  def ca_done?
    item.ca
  end

  def kr_done?
    item.kr
  end

  def ba_done?
    item.ba
  end

  def ua_done?
    item.ua
  end

  def qt_done?
    item.qt
  end

  def da_done?
    item.da
  end

  def rc_done?
    item.rc
  end

  def rp_done?
    item.rp
  end
end

class Item
  def ca
    true
  end

  def kr
    true
  end

  def ba
    false
  end

  def ua
    false
  end

  def qt
    false
  end

  def da
    false
  end

  def rc
    false
  end

  def rp
    false
  end
end

item = Item.new
proFlow = ProFlow.new(item)
# p proFlow.done
# p proFlow.not_done
# p proFlow.get_ready?(:da)
p proFlow.get_ready
