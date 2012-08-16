Kochiku::Application.routes.draw do
  mount Resque::Server.new, :at => '/resque'

  root :to => "projects#index"

  resources :projects, :only => [:index, :new, :show] do
    get 'status-report', :action => "status_report", :on => :collection
    get 'build-time-history', :action => "build_time_history", :defaults => { :format => 'json' }

    resources :builds, :only => [:create, :show] do
      post 'request', :action => "request_build", :on => :collection
      put 'abort', :action => "abort", :on => :member
      get 'status', :action => "build_status", :on => :member, :defaults => { :format => 'json' }
      resources :build_parts, :as => 'parts', :path => 'parts', :only => [:show] do
        post 'rebuild', :on => :member
      end
    end
  end
  match '/XmlStatusReport.aspx', :to => "projects#status_report", :defaults => { :format => 'xml' }

  match '/build_attempts/:build_attempt_id/build_artifacts' => "build_artifacts#create", :via => :post
  match '/build_attempts/:id/start' => "build_attempts#start", :via => :post
  match '/build_attempts/:id/finish' => "build_attempts#finish", :via => :post, :as => :finish_build_attempt
end
# TODO routing specs
