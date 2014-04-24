require "./graph_object"

class Edge < GraphObject

	def initialize(node_a, node_b, data=nil)
		super(data)
		@node_a = node_a
		@node_b = node_b
	end

	def graph
		super
	end

	def node_a
		@node_a
	end

	def node_a=(a)
		graph.update_edge_store(Edge.new(a, @node_b), self)
		@node_a=a
	end

	def node_b
		@node_b
	end

	def node_b=(b)
		graph.update_edge_store(Edge.new(@node_a, b), self)
		@node_b=b
	end
	
end