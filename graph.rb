require "./node"
require "./edge"
require './graph_edge'

# Author: Raphael Esterle
# This class holds all the data and manages it.

class Graph

	def initialize id
		# Unique id for the graph. Not uses yet.
		@id = id
		# Data associated with the nodes. [node_id -> data]
		@nodes_data = Hash.new
		# Data associated with the edges. [edge_id -> data]
		@edges_data = Hash.new
		# Bidirectional edgestore. 
		@edge_store_AB = Hash.new
		@edge_store_BA = Hash.new
		# Number of edges in graph.
		@edge_count = 0	
		# Cache for actual Objects
		@node_cache = Hash.new
	end
	
	def add_node node
		raise "#{node.id} is already included in graph" unless !@nodes_data.has_key?node.id
		@nodes_data.store(node.id, node.data)
		@edge_store_AB.store(node.id,Array.new)
		@edge_store_BA.store(node.id,Array.new)
	end

	def update_node_data node
		raise "#{node.id} is not part of graph" unless @nodes_data.has_key?node.id
		@nodes_data[node.id]=data
	end

	def add_edge edge

		# 1. Are the nodes for the edge sotored?
		is_node_in_graph edge.node_a.id
		is_node_in_graph edge.node_b.id

		# 2. Increment edge_count and set the new value as id for the new edge. (In search for a better Method)
		@edge_count = @edge_count.next
		edge.id = @edge_count.to_s

		# 3. Add edge to store
		add_to_edge_store(edge.node_a.id, edge.node_b.id)

		# 4. Store the associated data
		@edges_data.store(edge.id, edge.data)

		# 5. Set the graph_objects's graph to this one
		edge.graph=self

	end

	def is_edge_in_store?(node_a_id, node_b_id)
		@edge_store_BA[node_a_id].include?(node_b_id) && @edge_store_AB[node_b_id].include?(node_a_id)
	end

	def update_edge_store(edge, old_edge)
		add_to_edge_store(edge.node_a.id, edge.node_b.id)
		del_edge_store(old_edge.node_a.id, old_edge.node_b.id)
	end

	def del_edge_store(node_a_id, node_b_id)
		@edge_store_BA[node_a_id].delete(node_b_id)
		@edge_store_AB[node_b_id].delete(node_a_id)
	end

	def add_to_edge_store(node_a_id, node_b_id)
		raise "Edge already included in graph" unless !is_edge_in_store?(node_a_id, node_b_id)
		@edge_store_BA[node_a_id] << node_b_id
		@edge_store_AB[node_b_id] << node_a_id
	end

	def update_edge_data edge
		raise "Edge #{edge} is not part of the graph" unless @edges_data.has_key?edge.id
		@edges_data[edge.id] = edge.data
	end

	def each_a &block
		@edge_store_AB.each{|node| block.run node}
	end

	def is_node_in_graph node_id
		raise "node #{node_id} is not included in graph" unless @nodes_data.has_key?node_id
	end

	def dump
		puts "edges_data: #{@edges_data}"
		puts "nodes_data: #{@nodes_data}"
		puts "edge_store_BA: #{@edge_store_BA}"
		puts "edge_store_AB: #{@edge_store_AB}"
	end
end