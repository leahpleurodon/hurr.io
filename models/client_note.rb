class ClientNote < ActiveRecord::Base
    belongs_to :client
    belongs_to :employee, foreign_key: 'author_id'
end