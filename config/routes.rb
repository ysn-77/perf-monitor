Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope 'tests' do
    get '/',         to: 'performance_tests#list'
    get 'latest',    to: 'performance_tests#latest'

    post '/',        to: 'performance_tests#create'
  end
end
