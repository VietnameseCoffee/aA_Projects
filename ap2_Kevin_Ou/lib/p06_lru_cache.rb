require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    store.count
  end

  def get(key)
    node = map[key]
    if node
      update_node!(node)
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + map.to_s + '\n' + 'Store: ' + store.to_s
  end

  private

  attr_reader :map, :max, :store

  def calc!(key)
    node = store.append(key, @prc.call(key))
    eject! if count > max
    map[key] = node
    node.val
  end

  def update_node!(node)
    node.remove
    map[node.key] = store.append(node.key, node.val)
  end

  def eject!

    node = store.first
    node.remove
    map.delete(node.key)
  end
end