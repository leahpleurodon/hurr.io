require 'active_record'
require_relative '../models/appointment'

def seed_appointments

    data = [
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-26',
            start_time: '17:00',
            app_service: 'blow-wave',
            end_time:'19:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-27',
            start_time: '17:00',
            app_service: 'blow-wave',
            end_time:'19:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id:Client.where(active: true).sample.id,
            app_date: '2017-05-18',
            start_time: '17:00',
            app_service: 'cut and colour',
            end_time:'19:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-25',
            start_time: '12:00',
            app_service: 'hair up',
            end_time:'13:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-26',
            start_time: '12:00',
            app_service: 'hair up',
            end_time:'13:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-27',
            start_time: '12:00',
            app_service: 'hair up',
            end_time:'13:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-28',
            start_time: '12:00',
            app_service: 'hair up',
            end_time:'13:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        },
        {
            employee_id: Employee.where(active: true, terminated: false).sample.id,
            client_id: Client.where(active: true).sample.id,
            app_date: '2017-07-29',
            start_time: '12:00',
            app_service: 'hair up',
            end_time:'13:00',
            author_id: Employee.where(active: true, terminated: false).sample.id
        }
    ]

    data.each do |app|
        appointment = Appointment.new(
            employee_id: app[:employee_id],
            client_id: app[:client_id],
            app_date: app[:app_date],
            start_time: app[:start_time],
            app_service: app[:app_service],
            end_time: app[:end_time],
            author_id: app[:author_id],
            last_updated: Time.now,
            date_created: Time.now,
            active: true
        )
        appointment.save
    end
end