require 'active_record'
require_relative '../models/client'

def seed_clients

    data = [
        {
            first_name: "Leah",
            last_name: "Eramo",
            preferred_name: "Leia",
            title: "Baroness",
            email: "l@rea.co.au",
            dob: "1991-03-13",
            phone: "0412504247",
            active: true
        },
        {
            first_name: "Richard",
            last_name: "Starkey",
            preferred_name: "Ringo",
            title: "Sir",
            email: "ringo@beatles.com",
            dob: "1940-07-07",
            phone: "0412234442",
            active: true
        },
        {
            first_name: "John",
            last_name: "Lennon",
            title: "Sir",
            email: "john@beatles.com",
            dob: "1940-10-09",
            phone: "0422244222",
            active: false
        },
        {
            first_name: "George",
            last_name: "Harrison",
            title: "Sir",
            email: "george@beatles.com",
            dob: "1943-02-25",
            phone: "0416934859",
            active: false
        },
        {
            first_name: "Paul",
            last_name: "McCartney",
            title: "Sir",
            email: "paul@beatles.com",
            dob: "1942-06-18",
            phone: "0416943259",
            active: true
        }
    ]

    data.each do |client|
        c = Client.new(
            first_name: client[:first_name],
            password: client[:first_name],
            last_name: client[:last_name],
            preferred_name: client[:preferred_name] || client[:first_name],
            title: client[:title],
            email: client[:email],
            dob: client[:dob],
            phone: client[:phone],
            active: client[:active],
            last_update: Time.now,
            date_created: Time.now  
        )
        c.save
    end
end