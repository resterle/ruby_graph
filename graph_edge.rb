require "./edge"
require "./id"

class GraphEdge < Edge

	def initialize(edge, id, graph)
		super(edge.node_a, edge.node_b)
		@id = Id.new(id)
		@graph = graph
	end
	
	def id
		@id.id
	end

	def data=(a)
		super.data=a
	end
	
end