require 'tsort'

class Workflow
  include TSort

  def tsort_each_child(node)
    g[node].each do |child|
      yield child
    end
  end

  def tsort_each_node
    g.each_key do |node|
      yield node
    end
  end

  def g
    { a: [:b, :c], b: [:d], c: [:b, :d], d: [] }
  end

  def go
    each_strongly_connected_component do |node|
      p node
    end
  end
end

Workflow.new.go
