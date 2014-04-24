require "./graph"

graph = Graph.new('myGraph')

n0 = Node.new('node0', 'Node zeros data')
n1 = Node.new('node1')
n1.data='The data of node one'

e0 = Edge.new(n0, n1, 'some Data')
e1 = Edge.new(n1, n0)
e2 = Edge.new(n0, n0, 0)
e3 = Edge.new(n1, n1, 7)

graph.add_node n1
graph.add_node n0

graph.add_edge e1
graph.add_edge e0

e1.node_b=n1

graph.add_edge e2

n0.data << ', more'

graph.dump