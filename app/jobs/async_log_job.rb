class AsyncLogJob < ApplicationJob
  # queue_as :default
  # #queue_as :sidekiq
  
  # def perform(email,name)
  #   # Do something later
  #   UserMailer.with(to: email, name: name).welcome.deliver_later(wait: 10.seconds) 
  # end
end
