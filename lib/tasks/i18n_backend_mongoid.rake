namespace :i18n_backend_mongoid do
  desc 'Install i18n_backend_mongoid'
  task :install do
    system 'rails g i18n_backend_mongoid:install'
  end

  desc 'Uninstall i18n_backend_mongoid'
  task :uninstall do
    system 'rails d i18n_backend_mongoid:install'
  end
end
