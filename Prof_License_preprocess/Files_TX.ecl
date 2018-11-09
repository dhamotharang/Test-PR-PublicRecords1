EXPORT Files_TX  := module

rn_rec :=  
 record                                         
   string License_Number;                        
   string  Last_Name;                            
   string  First_Name;                           
   string  Middle_Name;                          
   string  Mailing_Address_Line_1;               
   string  Mailing_Address_Line_2;               
   string  Mailing_Address_Foreign_Line;         
   string  Mailing_Address_City;                 
   string Mailing_Address_State;                 
   string Mailing_Address_Zip_code;              
   string fieldtype;                         
   string Gender;                                
   string  Ethnicity;                            
   string  License_Status;                       
   string License_Status_Date;                   
   string Texas_License_Issuance_Date;           
   string  County_of_Residence;                  
   string  Employment_Status;                    
   string  Primary_Practice_Setting;             
   string  Primary_Practice_Position_Type;       
   string  Primary_Specialty;                    
   string  Highest_Degree;                       
   string  Basic_Nursing_Education;              
   string Current_Advanced_Practice_Recogniti;   
   string State_of_Original_Licensure;           
   string Date_of_Last_Renewal;                  
   string Date_of_Last_Update;                   
   string Current_Board_Action;                  
   string Date_of_Board_Action_Imposed;          
   string  Name_of_Basic_Nursing_School;         
   string State_of_Basic_Nursing_School;         
   string Entry_Date_into_Basic_Nursing_Schoo;   
   string Graduation_Date_from_Basic_Nursing_;   
   string field33;                               
   string lf;                                    
end;                                              

export RN_raw := dataset('~thor_data400::in::prolic::tx::nurse::rn::raw',rn_rec,CSV( separator('|'),terminator(['\n','\r\n']),Quote('"')));

aprn_rec := 
record                                             
   string License_Number;                          
   string  Last_Name;                              
   string  First_Name;                             
   string  Middle_Name;                            
   string  Mailing_Address_Line1;                  
   string  Mailing_Address_Line2;                  
   string  Mailing_Address_Foreign_Line;           
   string  Mailing_Address_City;                   
   string Mailing_Address_State;                   
   string Mailing_Address_Zipcode;                 
   string fieldtype;                           
   string Gender;                                  
   string  Ethnicity;                              
   string  County_of_Residence;                    
   string  APN_Category;                           
   string  APNSub_Catergory;                       
   string  APNSub_Catergory_Other;                 
   string  APNStatus;                              
   string APNExpiration_Date;                      
   string APNApproval_Date;                        
   string APNPrescriptive_AuthorizationNumber;     
   string  APNPrescriptive_AuthorizationStatus;    
   string APNPrescriptive_AuthorizationExpira;     
   string APNPrescriptive_AuthorizationApprov;     
   string lf;                                      
end;                                                

export APRN_raw := dataset('~thor_data400::in::prolic::tx::nurse::aprn::raw',aprn_rec,CSV( separator('|'),terminator(['\n','\r\n']),Quote('"')));

lvn_rec := 

record                                          
   string License_Number;                       
   string  Last_Name;                           
   string  First_Name;                          
   string  Middle_Name;                         
   string  Mailing_Address_Line_1;              
   string  Mailing_Address_Line_2;              
   string  Mailing_Address_Foreign_Line;        
   string  Mailing_Address_City;                
   string Mailing_Address_State;                
   string Mailing_Address_Zip_code;             
   string fieldtype;                        
   string Gender;                               
   string  Ethnicity;                           
   string  License_Status;                      
   string License_Status_Date;                  
   string Texas_License_Issuance_Date;          
   string  County_of_Residence;                 
   string  Employment_Status;                   
   string  Primary_Practice_Setting;            
   string  Primary_Practice_Position_Type;      
   string  Primary_Specialty;                   
   string  Highest_Degree;                      
   string  Basic_Nursing_Education;             
   string Current_Advanced_Practice_Recogniti;  
   string State_of_Original_Licensure;          
   string Date_of_Last_Renewal;                 
   string Date_of_Last_Update;                  
   string Current_Board_Action;                 
   string Date_of_Board_Action_Imposed;         
   string  Name_of_Basic_Nursing_School;        
   string State_of_Basic_Nursing_School;        
   string Entry_Date_into_Basic_Nursing_Schoo;  
   string Graduation_Date_from_Basic_Nursing_;  
   string field33;                              
   string lf;                                   
end;                                            
export LVN_raw := dataset('~thor_data400::in::prolic::tx::nurse::lvn::raw',lvn_rec,CSV( separator('|'),terminator(['\n','\r\n']),Quote('"')));

phy_rec := 

record                                   
   string UNIQUE_ID_NUMBER;              
   string PHYSICIAN_LICENSE_NUMBER;
	 string FIL;
   string  LAST_NAME;                    
   string  FIRST_NAME;                   
   string SUFFIX;                        
   string  MAILING_ADDRESS_LINE_1;       
   string  MAILING_ADDRESS_LINE_2;       
   string  MAILING_ADDRESS_CITY;         
   string MAILING_ADDRESS_STATE;         
   string MAILING_ADDRESS_ZIP_CODE;      
   string  PRACTICE_ADDRESS_LINE_1;      
   string  PRACTICE_ADDRESS_LINE_2;      
   string  PRACTICE_ADDRESS_CITY;        
   string PRACTICE_ADDRESS_STATE;        
   string PRACTICE_ADDRESS_ZIP_CODE;     
   string YEAR_OF_BIRTH;                 
   string  BIRTHPLACE;                   
   string  PRIMARY_SPECIALTY_CODE;       
   string  SECONDARY_SPECIALTY_CODE;     
   string MEDICAL_SCHOOL;                
   string MEDICAL_SCHOOL_GRAD_YEAR;      
   string MEDICAL_SCHOOL_DEGREE;         
   string LICENSE_ISSUANCE_DATE;         
   string METHOD_OF_LICENSURE_CODE;      
   string  RECIPROCITY_STATE_or_COUNTRY; 
   string LICENSE_EXPIRATION_DATE;       
   string PRACTICE_TYPE_CODE;            
   string PRACTICE_SETTING_CODE;         
   string PRACTICE_TIME_CODE;            
   string REGISTRATION_STATUS_CODE;      
   string REGISTRATION_STATUS_DATE;      
   string  COUNTY_NAME;                  
   string GENDER_CODE;                   
   string RACE_CODE;                     
   string HISPANIC_OR;                   
   string lf;                            
end;                                      

export phy_raw := dataset('~thor_data400::in::prolic::tx::medical::phy::raw',phy_rec,CSV( heading(1),separator('\t'),terminator(['\n','\r\n']),Quote('"')));

pas_rec :=

record                                
   string UNIQUE_ID_NUMBER;           
   string TEXAS_PA_LICENSE_NUMBER;    
   string  LAST_NAME;                 
   string  FIRST_NAME;                
   string SUFFIX;                     
   string  MAILING_ADDRESS_LINE_1;    
   string  MAILING_ADDRESS_LINE_2;    
   string  MAILING_ADDRESS_CITY;      
   string MAILING_ADDRESS_STATE;      
   string MAILING_ADDRESS_ZIP_CODE;   
   string  PRACTICE_ADDRESS_LINE_1;   
   string  PRACTICE_ADDRESS_LINE_2;   
   string  PRACTICE_ADDRESS_CITY;     
   string PRACTICE_ADDRESS_STATE;     
   string PRACTICE_ADDRESS_ZIP_CODE;  
   string YEAR_OF_BIRTH;              
   string  BIRTHPLACE;                
   string  PA_PROGRAM;                
   string PA_PROGRAM_GRADUATION_YEAR; 
   string PA_LICENSE_ISSUANCE_DATE;   
   string PA_LICENSE_EXPIRATION_DATE; 
   string PA_REGISTRATION_STATUS_CODE;
   string PA_REGISTRATION_STATUS_DATE;
   string  COUNTY_NAME;               
   string GENDER_CODE;                
   string RACE_CODE;                  
   string HISPANIC_ORIGIN;            
   string lf;                         
end;                                  

export pas_raw := dataset('~thor_data400::in::prolic::tx::medical::pas::raw',pas_rec,CSV( heading(1),separator('\t'),terminator(['\n','\r\n']),Quote('"')));

acpt_rec := 
record                                   
   string UNIQUEIDNUMBER;                
   string ACUPUNCTURELICENSENUMBER;      
   string  LASTNAME;                     
   string  FIRSTNAME;                    
   string SUFFIX;                        
   string  MAILINGADDRESSLINE1;          
   string  MAILINGADDRESSLINE2;          
   string  MAILINGADDRESSCITY;           
   string MAILINGADDRESSSTATE;           
   string MAILINGADDRESSZIPCODE;         
   string  PRACTICEADDRESSLINE1;         
   string  PRACTICEADDRESSLINE2;         
   string  PRACTICEADDRESSCITY;          
   string PRACTICEADDRESSSTATE;          
   string PRACTICEADDRESSZIPCODE;        
   string YEAROFBIRTH;                   
   string  BIRTHPLACE;                   
   string  ACUPUNCTURESCHOOLCODE;        
   string ACSCHOOLGRADUATIONYEAR;        
   string ACEDUCATIONCODE;               
   string ACMETHODOFLICENSURE;           
   string ACLICENSEISSUANCEDT;           
   string ACLICENSEEXPIRATIONDATE;       
   string ACREGISTRATIONSTATUSCODE;      
   string ACREGISTRATIONSTATUSDATE;      
   string  COUNTYNAME;                   
   string GENDERCODE;                    
   string RACECODE;                      
   string HISPANIC_ORIGIN;               
   string lf;                         
end;                                     
                                         
export acpt_raw := dataset('~thor_data400::in::prolic::tx::medical::acpt::raw',acpt_rec,CSV( heading(1),separator('\t'),terminator(['\n','\r\n']),Quote('"')));
                                         
                                         
                                         
end;