EXPORT File_HI_All_Available := module

Layout_HI_raw := record                                       
   string Board_Code;                        
   string  Sortname;                         
   string License_Type;                      
   string License_Number;                    
   string License_Office;                    
   string Record_Type;                       
   string Board_Alpha;                       
   string  License_Sortname;                 
   string Effective_Date;                    
   string Expiration_Date;                   
   string License_Status;                    
   string Status_Indicator;                  
   string Employment_Position_Code;          
   string Employment_Status;                 
   string Employer_License_Type;             
   string Employer_License_Number;           
   string Employer_License_Office_Number;    
   string  Employer_BP_Sortname;             
   string Special_Privilege_Indicator;       
   string License_Restriction_Indicator;     
   string Conditional_License_Indicator;     
   string  Business_Address_1;               
   string  Business_Address_2;               
   string  Business_City;                    
   string Business_State;                    
   string Business_Zipcode;                  
   string Business_Address_Restriction_Code; 
   string  Public_Address_1;                 
   string  Public_Address_2;                 
   string  Public_City;                      
   string Public_State;                      
   string Public_Zipcode;                    
   string Class_Prefix;                     
   string lf;                               
end;                                         
             


export File_aa := dataset('~thor_data400::in::prolic::hi::all_available::raw',Layout_HI_raw,CSV( separator(','),terminator(['\n']),Quote('"')));

end;