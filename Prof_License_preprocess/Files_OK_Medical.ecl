EXPORT Files_OK_Medical := module

 Layout_OK_raw := record                             
   //string ProfTYPE;                
   string  FIRSTNAME;              
   string  MIDDLENAME;             
   string  LASTNAME;               
   string SUFFIXNAME;              
   string  BIRTHDATE;
	 string BIRTHCITY;
	 string BIRTHSTATE;
	 string BIRTHCOUNT;
   string SEX;  
	 string ETHNICITY;
   string  ADDRLINE1;              
   string  ADDRLINE2;              
   string  ADDRLINE3;              
   string  CITY;                   
   string STATECODE;               
   string  ZIP;                    
   string  STATEPROV;              
   string  COUNTRY;                
   string  MailCounty;             
   string  PRACTADDR1;             
   string  PRACTADDR2;             
   string  PRACTADDR3;             
   string  PRACTCITY;              
   string PRACTSTATE;              
   string  PRACTZIP;               
   string  PRACTPROV;              
   string  PRACTCOUNTRY;           
   string  PractCounty;            
   string  Practice_Phone;
	 string LicType;
   string LicenseNum;              
   string IssueDate;               
   string DATEEXPIRE;              
   string STATUS;                  
   string  StatusClass;            
   string  Board_Certification1;   
   string Board_Certification2;    
   string Board_Certification3; 
   string EndorsedBy;
   string Specialty1;              
   string Specialty2;              
   string Specialty3;                                                
   string Specialty4; 
	 string Specialty5;
	 string LastMedSch;
	 string LastMedSchCity;
	 string LastMedSchCountry; 
	 string LastMedSchMFROM; 
	 string LastMedSchYFROM;
	 string LastMedSchMTo;
	 string LastMedSchYTo;
	 string MedSchDegree;
	 string DiscCount;
	 	 string DiscDate;
	 string DiscAct;
	 string Description;
	 string Disc_Remarks;
	 string lf;

                       
end;                                
      


export raw := dataset('~thor_data400::in::prolic::ok::medical::raw',Layout_OK_raw,CSV( heading(1),separator(','),terminator(['\n']),Quote('"'))) ;

export preprec := record                         
  string process_date;         
  string ProfTYPE;             
  string LASTNAME;             
  string FIRSTNAME;            
  string MIDDLENAME;           
  string SUFFIXNAME;           
  string BIRTHDATE;            
  string SEX;                  
  string ADDRLINE1;            
  string ADDRLINE2;            
  string ADDRLINE3;            
  string CITY;                 
  string STATECODE;            
  string ZIP;                  
  string STATEPROV;            
  string COUNTRY;              
  string COUNTYNAME;           
  string PRACTADDR1;           
  string PRACTADDR2;           
  string PRACTADDR3;           
  string PRACTCITY;            
  string PRACTSTATE;           
  string PRACTZIP;             
  string PRACTPROV;            
  string PRACTCOUNTRY;         
  string PRACTCOUNTY;          
  string Practice_Phone;       
  string License_No;           
  string License_Issue_Date;   
  string DATEEXPIRE;           
  string STATUS;               
  string Status_Class;         
  string Board_Certification1; 
  string Board_Certification2; 
  string Board_Certification3; 
  string Speciality_1;         
  string Speciality_2;         
  string Speciality_3;         
  string Speciality_4;         
  string Speciality_5;         
  string Medical_School_Name;  
  string Med_Sch_Foreign_Name; 
  string Med_Sch_YR_To;        
  string UG_Sch_Type;          
  string Disc_Action;          
  string Disc_Remarks;         
end;                           


end;