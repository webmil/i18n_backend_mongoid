namespace :venomi do
  desc 'Install venomi'
  task :install do
    system 'rails g venomi:install'
  end

  desc 'Uninstall venomi'
  task :uninstall do
    system 'rails d venomi:install'
  end
end
