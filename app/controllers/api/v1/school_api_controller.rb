class Api::V1::SchoolApiController < ApplicationController

skip_before_action :verify_authenticity_token



	def getAllSchools
	 	@Schools = School.select("schools.id , schools.school_name,  schools.school_city , schools.school_area , schools.\"school_feesRange\" , schools.school_logo,
                (select  ( (sum(rate1)/count(ratings.id))+ (sum(rate2)/count(ratings.id)) +(sum(rate3)/count(ratings.id)) + (sum(rate4)/count(ratings.id)) )/4 as Total_Rating 
	 	           	 from ratings where schools.id = ratings.school_id group by school_id ) , 
	 	           	 (select   count(id) as num_raters 
	 	           	 from ratings where schools.id = ratings.school_id group by school_id ) 
	 	 ").where("status = true")


	render json: @Schools.to_json
	 	#head :no_content
	end

 	def getSchoolByCat
    	@Schools = School.where(" \"school_eduSystem\" like '%" + params[:cat]+"%' and status = true")
    	render json: @Schools.to_json
    
  	end


  	def getRecentSchools
    	@Schools = School.select("schools.*").where("status = true").order("schools.id desc").limit(5)
    	render json: @Schools.to_json
    
  	end

  	def getTopRatingSchools
    	@Schools = School.select("schools.*").joins(' , "ratings" where schools."id" = "ratings"."school_id" and ("ratings".rate1+"ratings".rate2+"ratings".rate3+ "ratings".rate4)/4.0 > ' + params[:id])
    	render json: @Schools.to_json
    
  	end
  
	def getAllSchoolsNames
	@Schools = School.select('id, school_name,token').where(" status = true")	
	render json: @Schools.to_json
	#head :no_content
	end

	def add_new_school
	  @school = School.new(school_params)
	    if @school.save
	      render json: @school, status: :created
	    else
	      render json: @school.errors
	    end	
	end

	def get_school_info
	  #@school = School.find(params[:id])
	  #render json: @school
@Schools = School.select("schools.* ,
                (select  ( (sum(rate1)/count(id))+ (sum(rate2)/count(id)) +(sum(rate3)/count(id)) + (sum(rate4)/count(id)) ) /4 as Total_Rating 
	 	           	 from ratings where schools.id = ratings.school_id group by school_id ) , 
	 	           	 (select   count(id) as num_raters 
	 	           	 from ratings where schools.id = ratings.school_id group by school_id ) 
	 	 ").where("status = true AND id ="+params[:id]+"")


	render json: @Schools[0].to_json

	end
	  


	def get_all_job_vacancies
		@vacancies = JobVacancy.all	
		render json: @vacancies
	end
	def get_job_vacancy_details
	  @job_vacancy = JobVacancy.find(params[:id])
	  render json: @job_vacancy
	end

	def Search_school
      @school = School.find_school(params[:search_school])
      puts @school
      render json: @school
    end


	
	def find_school_withAdmissionON
      @school = School.where("admission_status = '1' AND status = true")
      render json: @school
    end
	
	
	
	
	def addmission
		$email = School.select("admission_email").where("id = " + params[:addmission_details][:school_id].to_s )
		puts "emaaail -------"
		puts $email[0]["admission_email"]
		UserMailer.vacancy_addmission_email(params[:addmission_details] , $email[0]["admission_email"]).deliver	  
	  	@school = School.all
      	render json: @school
    
	end 
    


    private
   
    def school_params
     params.require(:school).permit(:school_name, :school_description,
            :school_city,
            :school_area,
            :school_curriculum,
            :school_certificate,
            :school_eduSystem,
            :school_foreignTeachers,
            :school_feesRange,
            :school_availableGrades,
            :school_age,
            :school_website,
            :school_telephone,
            :school_email,
            :school_app,
            :school_address,
            :admission_status,
            :admission_email,
            :school_cafeteria,
            :school_soccerPlayground,
            :school_InnovationSpaces,
            :school_theater,
             :school_computerLabs,
             :school_scienceLab,
             :school_library,
             :school_swimmingPool,
             :school_logo,
             :school_images 
)
    end
end