class PagesController < ApplicationController		
	def getListPages
		_subpages = {}
		@pages.each do |page|
			if _subpages[page.page_id] then
				_subpages[page.page_id].push(page)
			else
				_subpages[page.page_id] = [page]
			end
		end
		return _subpages
	end
	
	def new
		@page = Page.new
	end
	
	def new_sub
		@page = Page.new
	end
	
	def index
		@pages = Page.all
		@_subpages = getListPages
		
	end
	
	def show
		@pages = Page.all
		@_subpages = getListPages
		
		@names = params[:name].split("/")
		@page = Page.find_by_name(@names[-1])
		@subpages = Page.where("page_id = ?", @page.id)
		
		@text = @page.text.gsub(/\*\*(.*?)\*\*/){ "<b>" + $1 + '</b>' }
		@text.gsub!(/\\\\(.*?)\\\\/){ "<i>" + $1 + '</i>' }
		@text.gsub!(/\(\((.*?)\s(.*?)\)\)/){ "<a href='#{$1}'>" + $2 + '</a>' }
	end
	
	def edit
		@names = params[:name].split("/")
		@page = Page.find_by_name(@names[-1])
	end
	
	def update
		@names = params[:name].split("/")
		@page = Page.find_by_name(@names[-1])

		if @page.update_attributes(params[:page])
			redirect_to :action => :show, :name => @page.getFullPath(@page.id).reverse.join("/")
		else
			render 'edit'
		end
	end
	
	def destroy
		@names = params[:name].split("/")
		@page = Page.find_by_name(@names[-1])
		@page.destroy

		redirect_to :action => :index
	end
	
	def create
		@page = Page.new(params[:page])
		@page.page = nil
		if @page.save
			redirect_to :action => :show, :name => @page.getFullPath(@page.id).reverse.join("/")
		else
			render 'new'
		end
	end
	
	def createSub
		@page = Page.new(params[:page]) 
		@names = params[:name].split("/")
		@page.page = Page.find_by_name(@names[-1])
		if @page.save
			redirect_to :action => :show, :name => @page.getFullPath(@page.id).reverse.join("/")
		else
			render 'new'
		end
	end
end
