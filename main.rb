require_relative 'item'
require_relative 'workflow/pro_flow'

item = Item.new
proFlow = ProFlow.new(item)
p proFlow.valid?
p proFlow.invalid?
p proFlow.done
p proFlow.not_done
p proFlow.get_ready?(:da)
p proFlow.get_ready
