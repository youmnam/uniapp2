Rails.application.routes.draw do
  resources :user_apps
get 'sessions/new'
get 'schools/text', to: 'schools#text', as: 'text'
get 'signup', to: 'users#new',        as: 'signup'
get 'login',  to: 'sessions#new',     as: 'login'
get 'logout', to: 'sessions#destroy', as: 'logout'
 
resources :sessions
resources :users
resources :user_apps
resources :schools do 
  resources :images ,:only => [:create, :destroy]
end

match 'schools/apply/:id'       ,  :to => 'schools#apply'   , :as => 'applyview'          ,:via => :get
match 'schools/applyjob/:id'       ,  :to => 'schools#applyjob'   , :as => 'apply'          ,:via => :post
match 'schools/:school_id/images', :to => 'images#create'   , :as => 'create_images'  ,:via => :post
match 'schools/approve/:id',       :to => 'schools#approve'  , :as => 'approve'       ,:via => :put
match 'schools/subscribe/:id',     :to => 'schools#subscribe', :as => 'subscribe'     ,:via => :put
  
namespace :api, :defaults => {:format => :json} do
    namespace :v1 do  
    	  get     "/getAllSchools",                to: "school_api#getAllSchools"
        get     "/getAllSchoolsNames",           to: "school_api#getAllSchoolsNames"
        get     "/getAllSchoolsWithAdmissionON", to: "school_api#find_school_withAdmissionON" 
    	  post    "/add_new_school",               to: "school_api#add_new_school"
    	  post    "/search_school",                to: "school_api#Search_school"
        get     "/getAllJobVacancies",           to: "school_api#get_all_job_vacancies"
        get     "/getSchoolInfo/:id",            to: "school_api#get_school_info"
        post    "/addmission",                   to: "school_api#addmission"
        get     "/getSchoolByCat/:cat",         to: "school_api#getSchoolByCat"
        get     "/getSchoolByCat/:cat",         to: "school_api#getSchoolByCat"

        get     "/getRecentSchools",         to: "school_api#getRecentSchools"
       



        post    "/add_school_rating",            to: "ratings#add_school_rating"
    	  post    "/getSchoolRating",              to: "ratings#getSchoolRating"
        get     "/getSchoolDetailsRating/:id",   to: "ratings#getSchoolDetailsRating"
        get     "/getSchoolRatersComments/:id",  to: "ratings#getSchoolRatingMessages"
  
        post    "/AddJobVacancy",              to: "job_vacancy#add_job_vacancy"
        get     "/getJobVacancyDetails/:id",   to: "job_vacancy#get_job_vacancy_details"
        post    "/searchForVacancy",           to: "job_vacancy#search_for_vacancy"
        post    "/job_addmission",             to: "job_vacancy#job_addmission"

        post    "/addTutorPosition",           to: "tutor#add_tutor_postion"
        get     "/getAllTutor",                to: "tutor#getAllTutor"
        
        
        post    "/addNews",                    to: "news#add_new_news"
        post    "/getNewsSchool",              to: "news#getNewsSchool"
        post    "/getAllNewsbyDate",           to: "news#getAllNewsbyDate"

        post     "/Authenticate",              to: "api#authenticate"

        post     "/addPost",                   to: "api#addPost"
        post     "/addComment",                to: "api#addComment"
        
        post     "/like",                       to: "api#like" 
        post     "/unlike",                     to: "api#unlike" 
        
        get      "/listPosts",                   to: "api#listPosts"
        get      "/listPostswithLike/:usrid",                   to: "api#listPostswithLike"
        get      "/listComments/:id",            to: "api#listComments"
        get      "/isLikedAllPosts/:id",         to: "api#isLikedAllPosts"
        get      "/listUsers",                   to: "api#listUsers"

        get      "/getPost/:id",                 to: "api#getPost"
        get      "/addRequest/:id",             to: "api#addRequest"
        post     "/AuthenticateSchool",              to: "api#authenticateSchool"

        get      "/enableChat/:id",                 to: "api#enableChat"
        post      "/addNotifications",             to: "api#addNotifications"
        post      "/seeNotifications",              to:  "api#seeNotifications"
        get      "/getNotifications/:user_id",             to: "api#getNotifications"
        get      "/getNumNotifications/:user_id",             to: "api#getNumNotifications"
     
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
