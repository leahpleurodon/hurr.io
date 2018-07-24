require 'active_record'
require_relative '../models/employee'

def seed_employees

    data = [
        {
            first_name: "Erica",
            last_name: "Murnane",
            title: "Miss",
            email: "erica@hurr.io",
            dob: "1990-03-07",
            phone: "0412504247",
            active: true,
            terminated: false,
            admin: true
        },
        {
            first_name: "Ashely",
            last_name: "Kelly",
            preferred_name: "Ash",
            title: "Miss",
            email: "ashley@hurr.io",
            dob: "1992-07-02",
            phone: "0412234442",
            active: false,
            terminated: false,
            admin: false
        },
        {
            first_name: "Lindy",
            last_name: "Davis",
            title: "Ms.",
            email: "lindy@hurr.io",
            dob: "1959-04-12",
            phone: "0422244222",
            active: true,
            terminated: false,
            admin: true
        },
        {
            first_name: "Taylor",
            last_name: "Lovelace",
            title: "Miss",
            email: "taylor@hurr.io",
            dob: "1959-04-12",
            phone: "0422244222",
            active: true,
            terminated: true,
            date_terminated: '2015-04-09',
            admin: true
        }
    ]

    data.each do |employee|
        c = Employee.new(
            first_name: employee[:first_name],
            password: employee[:first_name],
            last_name: employee[:last_name],
            preferred_name: employee[:preferred_name] || employee[:first_name],
            title: employee[:title],
            email: employee[:email],
            dob: employee[:dob],
            phone: employee[:phone],
            active: employee[:active],
            admin: employee[:admin],
            date_started: Time.now,
            terminated: employee[:terminated],
            date_terminated: employee[:date_terminated] || nil,
            last_update: Time.now,
            date_created: Time.now  
        )
        c.save
    end
end