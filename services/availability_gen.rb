class AvailabilityGen
    attr_reader :emp_available_times
    def initialize(appointments, shifts)
        @shifts = shifts
        @appointments = appointments
        @emp_available_times = {}
    end
    
    def generate!
        gen_day_intervals
        block_booked_times
        return self
    end
    def gen_day_intervals
        @shifts.each do |shift|
            temp_intervals = []
            time = shift.start_time
            while ( time + 15.minutes) <= shift.end_time
                temp_intervals.push(time)
                time = time + 15.minutes
            end
            @emp_available_times[shift.employee.id] = temp_intervals
        end
    end
    
    def block_booked_times
        @appointments.each do |app|
            @emp_available_times[app.employee.id].each_with_index do |interval, index|
                if (second_of_day(interval)...second_of_day(interval + 90.minutes)).overlaps?(second_of_day(app.start_time)...second_of_day(app.end_time))
                    @emp_available_times[app.employee.id][index] = '-'
                end
            end
            @emp_available_times[app.employee.id].reject! { |x| x == '-'}
        end
    end

end