EXPORT File_MA_Physician := module

Layout_MA_raw := record                                
   string  license;                   
   string  NPI;                       
   string  license_status;            
   string license_class;              
   string  last_name;                 
   string  first_name;                
   string middle_init;                
   string generation;                 
   string  birthdate;                 
   string gender;                     
   string  specialty_1;               
   string  specialty_2;               
   string  specialty_3;               
   string  specialty_4;               
   string b_spec1_board;              
   string  b_spec1_board_name;        
   string  b_spec1_cert;              
   string  b_spec1_subspecialty;      
   string b_spec2_board;              
   string  b_spec2_board_name;        
   string  b_spec2_cert;              
   string  b_spec2_subspecialty;      
   string b_spec3_board;              
   string  b_spec3_board_name;        
   string  b_spec3_cert;              
   string  b_spec3_subspecialty;      
   string b_spec4_board;              
   string  b_spec4_board_name;        
   string  b_spec4_cert;              
   string  b_spec4_subspecialty;      
   string  license_orig_approval_date;
   string  license_renewal_date;      
   string grad_school_loc_code;       
   string  grad_school_name;          
   string  graduation_date;           
   string degree;                     
   string addr_type_code;             
   string  addr_line_1;               
   string  addr_line_2;               
   string  addr_city;                 
   string addr_state;                 
   string addr_zip_code;              
   string  addr_country;              
   string  addr_phone_nbr;            
   string addr_phone_ext;             
   string  work_setting;              
   string  hos_affil_1;               
   string  hos_affil_2;               
   string  hos_affil_3;               
   string  hos_affil_4;               
   string  hos_affil_5;               
   string  hos_affil_6;               
   string lf;                         
end;                                   


export raw := dataset('~thor_data400::in::prolic::ma::physician::raw',Layout_MA_raw,CSV( separator(','),terminator(['\n']),Quote('"')));

end;