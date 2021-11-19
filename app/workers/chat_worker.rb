class ChatWorker
  include Sidekiq::Worker
  
  def perform(token, chats_count)
    application = Application.find_by(token: token)

    Chat.new(application_id: application.id, sequential_number: chats_count).save
    application.update(chats_count: chats_count)
  end
end