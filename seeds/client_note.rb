require 'active_record'
require_relative '../models/client_note'

def seed_client_notes

    data = [
        {
            note: "Testing the Notes function for Paul--",
            active: true,
            client: Client.where(first_name: "Paul")[0].id,
            author: Employee.where(active: true).sample.id
        },
        {
            note: "Testing the Notes function for Ringo",
            active: true,
            client: Client.where(first_name: "Richard")[0].id,
            author: Employee.where(active: true).sample.id
        },
        {
            note: "Testing the Notes function for John",
            active: true,
            client: Client.where(first_name: "John")[0].id,
            author: Employee.where(active: true).sample.id
        },
        {
            note: "Testing the Notes function for George",
            active: true,
            client: Client.where(first_name: "George")[0].id,
            author: Employee.where(active: true).sample.id
        },
        {
            note: "Testing the Notes function for Leah",
            active: true,
            client: Client.where(first_name: "Leah")[0].id,
            author: Employee.where(active: true).sample.id
        },
        {
            note: "Testing the inactive Notes function for Leah",
            active: false,
            client: Client.where(first_name: "Leah")[0].id,
            author: Employee.where(active: true).sample.id
        },        
        {
            note: "Testing inactive Notes function for paul",
            active: false,
            client: Client.where(first_name: "Paul")[0].id,
            author: Employee.where(active: true).sample.id
        }
    ]

    data.each do |note|
        c = ClientNote.new(
            note: note[:note],
            active: note[:active],
            client_id: note[:client],
            last_update: Time.now,
            date_created: Time.now,
            author_id: note[:author]
        )
        c.save
    end
end