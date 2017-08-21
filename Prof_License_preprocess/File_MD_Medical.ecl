EXPORT File_MD_Medical := module

Layout_MD_raw := record                                       
string lic_no;               
string  phy_last_name;       
string  phy_first_name;      
string generation;           
string  address1;            
string  address2;            
string  city;                
string state;                
string  zipcode;             
string  foreign_country;     
string how_licensed;         
string renew_year;           
string phy_lic_stat;         
string date_orig_lic;        
string  expiration_date;     
string  specialty_title;     
string lf;                   
    
end;                                         
             


export raw := dataset('~thor_data400::in::prolic::md::medical::raw',Layout_MD_raw,CSV( separator(','),terminator(['\n']),Quote('"')));

end;