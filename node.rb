require './graph_object'

class Node < GraphObject

	def initialize(id, data=nil)
		super(data, id)
	end

end