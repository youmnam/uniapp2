class SchoolTokenMailer < ApplicationMailer
default from: "magdy.youmna@gmail.com"




def send_token(school)
    @school = school 
    mail(to: "magdy.youmna@gmail.com" , subject: "#{@school.school_name} has been approved!")
end





end