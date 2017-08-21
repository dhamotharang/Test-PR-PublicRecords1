EXPORT File_PA_All_Available := module

Layout_IDActive_A := 
record                        
   string license_number;     
   string  addr_1;            
   string  name;              
   string  addr_2;            
   string  addr_3;            
   string  city;              
   string state;              
   string zip;                
   string  county;            
   string  issue_date;        
   string  expiration_date;   
   string lf;                 
end;

export IDActiveA_raw :=       dataset('~thor_data400::in::prolic::pa::all_available::id_active_a::raw',Layout_IDActive_A,CSV( separator(','),terminator(['\n']),Quote('"')));                    

Layout_IDActive_B := 
record                      
   string license_number;   
   string  first_name;      
   string  middle_name;     
   string  last_name;       
   string  suffix;          
   string  addr_1;          
   string  addr_2;          
   string  addr_3;          
   string  city;            
   string  state;           
   string  zip;             
   string  county;          
   string  issue_date;      
   string  expiration_date; 
   string  field14;         
   string  field15;         
   string lf;               
end;                        

export IDActiveB_raw :=       dataset('~thor_data400::in::prolic::pa::all_available::id_active_b::raw',Layout_IDActive_B,CSV( separator(','),terminator(['\n']),Quote('"')));    

 Layout_IDInActive_A := 
record                        
   string license_number; 
	 string dbname;
   string  name;              
   string  city;              
   string state;              
   string zip;                
   string  county;            
   string  issue_date;        
   string  expiration_date;   
   string lf;                 
end;  

export IDInActiveA_raw :=       dataset('~thor_data400::in::prolic::pa::all_available::id_inactive_a::raw',Layout_IDInActive_A,CSV( separator(','),terminator(['\n']),Quote('"')));                    
 
Layout_IDInActive_B :=   
record                        
   string license_number; 
	  string  first_name;      
   string  middle_name;     
   string  last_name;       
   string  suffix;          
   string  city;              
   string state;              
   string zip;                
   string  county;            
   string  issue_date;        
   string  expiration_date;
   string field11;
   string lf;                 
end;  
export IDInActiveB_raw :=       dataset('~thor_data400::in::prolic::pa::all_available::id_inactive_b::raw',Layout_IDInActive_B,CSV( separator(','),terminator(['\n']),Quote('"')));                    
 
end;