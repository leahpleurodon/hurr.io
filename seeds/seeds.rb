require_relative 'client'
require_relative 'client_note'
require_relative 'employee'

def seed!
    seed_clients
    seed_employees
    seed_client_notes
end