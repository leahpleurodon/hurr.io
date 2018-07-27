require 'pony'

class HurrMail

    def initialize(body, subject, email)
        @body = body
        @subject = subject
        @email = email
    end

    def send!
        Pony.mail({
            :to => @email,
            :via => :smtp,
            :via_options => {
                :address => 'smtp.gmail.com',
                :port => '587',
                :enable_starttls_auto => true,
                :user_name => ENV['GMAILSMTPUSER'],
                :password => ENV['GMAILSMTPPASS'],
                :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                :domain => "localhost.localdomain" # the HELO domain provided by the client to the server
            },
            :subject => @subject, 
            :body => @body
        })
    end

end