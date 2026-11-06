Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Stateless OTP Authentication
      post "auth/request_otp", to: "auth#request_otp"
      post "auth/verify_otp", to: "auth#verify_otp"
      get  "auth/me", to: "auth#me"

      # Public Courses & deep links
      get "courses/lookup", to: "courses#lookup"

      resources :courses, only: [:index, :show, :create] do
        member do
          get :export_csv
        end

        resources :registrations, only: [:create, :update] do
          collection do
            get :check
          end
        end
      end

      # Certificate inspection & preview
      resources :registrations, only: [:show]

      # Protected Admin Portal
      namespace :admin do
        get    "dashboard/stats", to: "dashboard#stats"
        get    "dashboard/students", to: "dashboard#students"
        patch  "dashboard/students/:id", to: "dashboard#update_student"
        get    "dashboard/export_all_csv", to: "dashboard#export_all_csv"
        resources :admins, only: [:index, :create, :destroy]
      end
    end
  end

  get "up" => proc { [200, { "Content-Type" => "application/json" }, [{ status: "ok", timestamp: Time.current }.to_json]] }
end

