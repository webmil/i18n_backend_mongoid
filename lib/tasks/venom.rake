namespace :venom do
  desc 'Install venom'
  task :install do
    system 'rails g venom:install'
  end

  desc 'Uninstall venom'
  task :uninstall do
    system 'rails d venom:install'
  end
end
