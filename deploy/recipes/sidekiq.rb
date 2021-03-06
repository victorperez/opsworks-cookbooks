#
# Cookbook Name:: deploy
# Recipe:: sidekiq

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping deploy::rails-restart application #{application} as it is not a Rails app")
    next
  end

  service 'sidekiq' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :stop => true, :restart => true
    action :restart
  end
end
