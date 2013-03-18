Wiki::Application.routes.draw do
	
	root :to => "pages#index"
	get 'add' => 'pages#new'
	post "pages/create"
	get "*name/add" => "pages#new_sub", :as => :name_add
	get "*name/edit" => "pages#edit", :as => :name_edit
	post "*name/create" => "pages#createSub", :as => :name_create
	put "*name/update" => "pages#update", :as => :name_update
	delete "*name/destroy" => "pages#destroy", :as => :name_delete
	get "*name" => "pages#show", :as => :page
	
end
