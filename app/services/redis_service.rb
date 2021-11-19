class RedisService
  
  def cache_messages_count(chat, application_token)
    key = "#{application_token}_#{chat.sequential_number}#_messages_count"
    cache(key, chat.messages_count)
    messages_count = REDIS_CLIENT.incr(key)
    expire(key)
    return messages_count
  end

  def cache_chats_count(application)
    key = application.token
    cache(key, application.chats_count)
    chats_count = REDIS_CLIENT.incr(key)
    expire(key)
    return chats_count
  end

  private

  def expire(key)
    REDIS_CLIENT.expire(key, 60*60)
  end

  def cache(key, value)
    if REDIS_CLIENT.exists?(key) == false
      REDIS_CLIENT.set(key, value)
    end
  end

end