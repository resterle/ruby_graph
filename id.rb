class Id
	def initialize(id)
		raise "id must be String" unless id.is_a?String
		@id = String.new id
	end
	
	def id
		String.new @id
	end
	
end