class School < ApplicationRecord
    
    mount_uploader :school_logo, ImageUploader
    mount_uploaders :school_images, ImageUploader

	after_validation :token_create  , on: :create
	validates_uniqueness_of :token ,on: :create
=begin	
	validates :school_name ,:school_description ,:school_website ,:school_app,:school_email,:school_telephone,:school_address,:admission_email,:school_feesRange,:school_eduSystem,:school_curriculum,:school_availableGrades,:school_age,:school_age,:school_logo,:school_images,presence: true 
	validates :school_age,:school_telephone,:school_availableGrades,:school_feesRange,numericality: { only_integer: true }
	validates :school_name,:school_website,:school_email, uniqueness: true
	validates :school_email,:admission_email ,email_format: { message: "doesn't look like an email address" }
	validates :school_website , :url => true
	validate :city_and_area ,on: :create
=end
	private 

    def city_and_area
		if self.school_city == 'nil' && self.school_area =='nil'
		  errors.add(:school_city, "Please Choose the City and the Area of the School")
		end  
 	end	


	def token_create

	self.token = loop do
	      random_token = SecureRandom.base58(7).downcase
	      break random_token unless School.exists?(token: random_token)
	    end
	end


#educational approach : [0] Internaional [1] American , [2] British , [3]French, [4]Deutsche, [5]Candian
def self.find_school( searchCrieria )
 
 $query = " 1 = 1 "
 
 if searchCrieria[:educational_approach].length != 0 && searchCrieria[:educational_approach] != " '' " 
 		#$query += " AND  \"school_eduSystem\" IN " + "("+ searchCrieria[:educational_approach] +") "
       $eduQuery = ""

         
			
			searchCrieria[:educational_approach].each do |c|
			
			    $eduQuery += "  \"school_eduSystem\" like   "
				$eduQuery += "'%#{c}%' or "  
			 	 
		end
			n = $eduQuery.size
			$ValuesIn = $eduQuery[0..n-4]
			 
			
			
			$query += " AND "+ $ValuesIn +" "		
			
			#if $ValuesIn.size != 2
			#$query += " AND  \"school_eduSystem\" like " + " "+ $ValuesIn +" "		
			#end 
 end

 if searchCrieria[:area] != "" && searchCrieria[:area] != " '' "
    $query += " AND  school_area in " + "("+searchCrieria[:area]+")"
 end

 if searchCrieria[:specialNeed] != nil && searchCrieria[:specialNeed] != "" && searchCrieria[:specialNeed] != " '' "
    $query += " AND  \"specialNeed\" = " +searchCrieria[:specialNeed]+""
 end

 
 if searchCrieria[:grades_availabilty] != "" && searchCrieria[:grades_availabilty] != " '' "
    $query += " AND  \"school_availableGrades\" in " + " (#{searchCrieria[:grades_availabilty]}) "
 end

 if searchCrieria[:amissionStatus] != "" 
    $query += " AND  \"admission_status\"  = " + "'#{searchCrieria[:amissionStatus]}'"
 end


   
  $query  += " AND \"school_feesRange\" != '' AND \"school_feesRange\"::integer " + " BETWEEN  " + "#{searchCrieria[:FFees]}" +" AND " + "#{searchCrieria[:TFees]}"
  
  where($query)
 
 end

end
