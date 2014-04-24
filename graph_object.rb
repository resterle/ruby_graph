require "./id"

# Superclass for Edges and Nodes. Connection between the graph objects and the graph itself.

class GraphObject

	def initialize(data, id=nil)		
		@data = data
		@id = id
		if id!=nil
			@id = Id.new(id) 
		end
		@graph = nil
	end
	
	def graph
		@graph
	end

	def graph=(g)
		if(nil==@graph)
			@graph=g
		end
	end

	def id
		@id.id
	end

	def id=(a)
		@id=Id.new(a)
	end

	def data
		@data
	end

	def data=(a)
		@data = a
		if @graph!=nil
			if self.class==Edge
				@graph.update_edge_data(self)
			end
			if self.class==Node
				@graph.update_node_data(self)
			end
		end
	end
	
end