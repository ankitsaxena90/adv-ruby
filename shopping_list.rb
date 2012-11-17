class Shopping
  def initialize
    @item_array = []
    @shopping_hash = Hash.new(0)
  end

  def add_item(item)
    @shopping_hash['item_name'] = item
  end

  def quantity(qty)
    @shopping_hash['quantity'] = qty
  end

  def display
    @item_array.push(@shopping_hash)
    @item_array.each { |val| puts val }
  end

  def item_list(&block)
    instance_eval(&block)
  end
end

item1 = Shopping.new
item1.item_list do
  add_item('Sony Camera')
  quantity(4)
  display()
end

item2 = Shopping.new
item2.item_list do
  add_item('HTC OneV')
  quantity(5)
  display()
end