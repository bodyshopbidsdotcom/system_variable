Rails.application.routes.draw do
  mount SystemVariable::Engine => "/system_variable"
end
