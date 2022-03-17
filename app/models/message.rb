class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  validates :body, presence: true
  validates :sequential_number, presence: true
  validates :sequential_number, uniqueness: {scope: :chat}

  settings analysis: {
    analyzer: {
      search_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: ['lowercase']
      }
    }
  } do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: "search_analyzer"
    end
  end

  def self.search_body(chat_id, body)
    self.search({ 
      query: {
        bool: {
           must: [
             {
               wildcard: {
                 body: {
                   value: "*#{body}*"
                 }
               }
             },
             {
               match: {
                 chat_id: chat_id
               }
             }
           ]
        }
      }
    }).records.records
  end
end
