EXPORT Layouts_GA_raw := module

export aa := record                           
   string License_No;      
   string sort_name;       
   string full_name;       
   string LicenseType;     
   string status;          
   string issue_date;      
   string expiration_date; 
   string addr_line_1;     
   string addr_line_2;     
   string addr_line_3;     
   string addr_line_4;     
   string addr_city;       
   string addr_state;      
   string addr_zipcode;    
   string addr_county;     
   string  lf;            
end  ;  


export medraw := 
record                             
//   string  Client;                 
   string  Full_Name;              
   string  LicenseType;
   string  License;  
   string  Status;                 
   string  Date_of_First_License;  
   string  Expiration; 
   string  Designation;            
   string  Address_1;              
   string  Address_2; 
   string  Address_3;              
   string  Address_4;              

   string  City;                   
   string  State;                  
   string  ZIP;
  string County;
  // string  Status;                 
  // string  Designation;            
   string  Speciality;             
   string  PBO;                    
   string  PBDate;                 
   string lf;                      
end;   


export lpn_raw := 
record                      
                       
   string license_no;     
   string sort_name;      
   string full_name;      
   string license_type;   
   string status;         
   string issue_date;     
   string expiration_date;
   string addr_line1;     
   string addr_line2;     
   string addr_line3;     
   string addr_line4;     
   string city;           
   string state;           
   string zip;            
   string county;         
   string lf;             
end;   

export rn_raw := 
record                      
                       
   string license_no;     
   string sort_name;      
   string full_name;      
   string license_type;   
   string status;         
   string issue_date;     
   string expiration_date;
   string addr_line1;     
   string addr_line2;     
   string addr_line3;     
   string addr_line4;     
   string city;           
   string state;           
   string zip;            
   string county;         
   string lf;             
end;                       
  
end;