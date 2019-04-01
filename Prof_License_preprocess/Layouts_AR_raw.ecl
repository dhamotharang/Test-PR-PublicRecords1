EXPORT Layouts_AR_raw := module

export DDS := record
   string  First_Name;                   
   string  Last_Name;  
	 string  Status;
	 string Degree;
	 string Home_Address;
	 string  City;
	 string State;                         
   string Zip_Code;                      
   string  Office_Phone;                 
   string  Fax_Number;                   
   string  Email; 
   string County;
	 string License_Number; 
	 string Date_of_license;
	 string Expiration_Date;
	 string  DEA_License_Number;           
   string  Date_of_Birth;                
   string Sex;                           
   string Race;     
	 string Dental_School;
	 string Date_Graduated;
   string  Speciality;                   
   string  Corporation_1;                
   string Legal_Notes;
	 string lf;
end;

export RDA := record
     string  First_Name;        
     string  Last_Name;         
     string  Address;           
     string  City;              
     string State;              
     string Zip_Code;           
     string  Phone;
     string  Email; 
		 string  County;
     string  Date_of_Birth;     
     string License_Number;     
     string  Date_of_License;   
     string  Expiration_Date;   
     string Status;
		 string Office_Phone_Number;
     string lf;                 
    
                         

end;

export RDH := record
       string  First_Name;           
       string  Last_Name;            
       string Degree;           
       string  Address;             
       string  City;                 
       string State;                 
       string Zip_Code;              
       string  Home_Phone;
			 string Office_Phone;
       string  Email;
			 string County;
       string License_Number;        
       string  Date_of_License;      
       string  Expiration_Date;      
       string  Date_of_Birth;                  
       string Gender;                
       string Race;               
       string  Maiden_Name;                 
       string Former_Name;               
       string  Degree_Type; 
			 string Dental_School;
			 string Permit_Number;
			 string Supervision_Type;
       string  Legal_Notes;              
       string TxtLicNo;               
       string lf;                    

end;

export optometry := 
record     
   string  Firstname; 
	 string Initals;          
   string  Lastname;        
   string  Mailing_Address; 
   string  Mail_City;       
   string Mail_State;       
   string  Mail_Zipcode;
	 string Office_Phone;
	 string Fax_Phone;
   string  LicNum;    
   string  Date_Licensed;       
   string Licenses_Expires;           
   string  Status; 
	 string School;
   string Date_Graduated;   
	 string DOB;  
	 string Disciplinary;
   string EMAIL_ADDRESS;
   string lf;                 
end;                        

export pharmacy := 
 record
   string First_Name;
   string Middle_Name;
   string Last_Name;
    string Gender;              
    string  Mail_Street;        
    string  Mail_City;          
    string Mail_State;          
    string  Mail_Zip;           
    string  Mail_County;        
    string  Mail_HomePhone;     
    string  Mail_WorkPhone;     
    string  Mail_Fax;           
    string  LicenseType;        
    string LicenseNumber;       
    string LicenseStatus;       
    string  EffectiveDate;      
    string  ExpirationDate;     
    string lf;                  
 end;                            
                                



end;
