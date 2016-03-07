workers Integer(ENV['PUMA_WORKERS'] || 2)
threads_count = Integer(ENV['PUMA_THREADS'] || 2)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
