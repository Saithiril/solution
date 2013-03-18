class Page < ActiveRecord::Base
	attr_accessible :name, :text, :title, :page_id
	belongs_to :page
	
	def outTree(parent_id, level)
		#метод, генерирующий списки страниц дерева
		@sub = "<ul>"
		if @_subpages[parent_id] then
			@_subpages[parent_id].each do |subpage|
				# @sub += "<li>#{subpage.title}</li>"
				@sub += "<li><a href=/#{getFullPath(subpage.id).reverse.join('/')}>#{subpage.name}</a></li>"
				level += 1
				@sub += outTree(subpage.id, level)
				level -= 1
			end
		end
		return @sub + "</ul>"
	end
	
	def getFullPath(id)
		# получение полного пути к указанной странице
		@name = Page.find(id)
		@path = [@name.name]
		if @name.page then
			return @path + getFullPath(@name.page.id)
		else
			return @path
		end
	end
		
	def getsubpages(subpages)
		# старт генерации дерева страниц
		@_subpages = subpages
		
		return outTree(self.id, 0)
	end
end
