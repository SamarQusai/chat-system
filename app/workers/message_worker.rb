class MessageWorker
  include Sidekiq::Worker
  
  def perform(chat_id, messages_count, message_body)
    chat = Chat.find(chat_id)
    
    Message.new(chat_id: chat.id, sequential_number: messages_count, body: message_body).save
    
    chat.update(messages_count: messages_count)
  end
end