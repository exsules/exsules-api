web: bundle exec puma -p ${PORT:="3000"} -C config/puma.rb
worker: bundle exec sidekiq -q exsules_default -q exsules_mailers
mailhog: mailhog
