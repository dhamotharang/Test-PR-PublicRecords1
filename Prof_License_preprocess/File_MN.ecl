EXPORT File_MN :=  module

Layout_MN_Dentist := record                 
   string LICNUM;      
   string  OLD;        
   string  EXPDATE;    
   string LICTYPE;     
   string STATUS;      
   string  LNAME;      
   string  FNAME;      
   string  MNAME;      
   string  ADDRESS1;   
   string  ADDRESS2;   
   string  ADDRESS3;   
   string  CITY;       
   string STATE;       
   string  ZIPCODE;    
   string  COUNTRY;    
   string GENDER;      
   string  DOB;        
   string  INSTITUTION;
   string  LOCATION;   
   string GRADUATE;
	 string field21;
   string COUNTY;      
end;                    
               
             


export dentist := dataset('~thor_data400::in::prolic::mn::dentist',Layout_MN_Dentist,CSV( separator(','),terminator(['\n']),Quote('"')));


Layout_MN_Architect := record              
   string LICTYPE;  
   string  LNAME;   
   string  FNAME;   
   string LICNUM;
   string field5;
   string  BUSNAME;
   string  ADDRESS1;
	 string ADDRESS2;
   string  CITY;    
   string STATE;    
   string  ZIPCODE; 
   string COUNTRY;  
   string OLD;      
   string EXPDATE;  
   string COUNTY;   
   string lf;       
end;                

export architect := dataset('~thor_data400::in::prolic::mn::architect',Layout_MN_Architect,CSV( separator(','),terminator(['\n']),Quote('"')));

Layout_MN_CPA := record                
   string LICNUM;     
   string OLD;        
   string EXP_DATE;   
   string STATUS;     
   string LICTYPE;    
   string  LNAME;     
   string  FNAME;     
   string  MNAME;     
   string  ADDRESS1;  
   string  ADDRESS2;  
   string  CITY;      
   string STATE;      
   string  ZIPCODE;   
   string MAIL_TO;    
   string  EMPLOYER;  
   string COUNTY;     
   string lf;         
end;                   

export cpa := dataset('~thor_data400::in::prolic::mn::cpa',Layout_MN_CPA,CSV( separator(','),terminator(['\n']),Quote('"'))) ( LICNUM <> 'Licno' );


Layout_MN_BLDG := record 
string Name;                   
string  DBA;           
string  Addr1;         
string  Addr2;         
string  City;          
string St;             
string ZIP;            
string LicNumber;      
string CE_Status;      
string Orig_Date;      
string Exp_Date;       
string  Phone_No;      
string Countycode;     
string lf;             

                        
end;                     

export bldg := dataset('~thor_data400::in::prolic::mn::bldgcont',Layout_MN_BLDG,CSV( heading(1),separator(','),terminator(['\n']),Quote('"'))) (DBA <> 'DBA');

Layout_MN_Engr := record                  
   string LICTYPE;      
   string  LNAME;       
   string  FNAME;       
   string LICNUM;       
   string  DISCIPLINE;  
   string  ADDRESS1;    
   string  ADDRESS2;
	 string ADDRESS3;
   string  CITY;        
   string STATE;        
   string  ZIPCODE;     
   string  COUNTRY;     
   string OLD;          
   string EXPDATE;      
   string COUNTY;       
   string lf;           
end;                     

export engr := dataset('~thor_data400::in::prolic::mn::engineer',Layout_MN_Engr,CSV( separator(','),terminator(['\n']),Quote('"')));

Layout_MN_Vet := record 
   string  LastName;    
    string  FirstName;   
   string  MiddleName;  
   string  Addr1;       
   string  Addr2;  
	 string Addr3;
   string  City;        
   string  St;          
   string  Zip;
	  string Licen;
			string LicenseS;     
   string IssueDate;    
   string ExpireDate;  
	    string CountyCode;
			string County;    
   string lf;           
                        
end;                    

export vet := dataset('~thor_data400::in::prolic::mn::vets',Layout_MN_Vet,CSV( separator(','),terminator(['\n']),Quote('"')));

Layout_MN_Phy := 
record                           
   string  licenseType;
	  string  license_nbr;
		 string  license_status;
		 string disciplined;
		 string  grant_date;           
   string  expire_date;
	  string Birthyear;
   string Gender;                
   string  first_name;           
   string  middle_name;          
   string  last_name;            
   string  degree;               
   string  address_line1;        
   string  address_line2;        
   string  address_line3;        
   string  city;                 
   string state;                 
   string  zip;                  
   string  country;
	   string  email;                
   string phone;
   string  county;              
   string  lf;                   
end;

export phy := dataset('~thor_data400::in::prolic::mn::physician',Layout_MN_Phy,CSV( separator(','),terminator(['\n']),Quote('"')));
                              

end;





