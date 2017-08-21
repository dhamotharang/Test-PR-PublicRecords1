EXPORT Files_VA_raw := module

Layout_VA_raw := record                       
   string  license_number;   
   string  profession;       
   string  name;             
   string  address1;         
   string  address2;         
   string  city;             
   string st;                
   string  zip;              
   string  issue_date;       
   string  expiration_date;  
   string expired;           
   string lf;                
end;                          


export health := dataset('~thor_data400::in::prolic::va::health::raw',Layout_VA_raw,CSV( separator('|'),terminator(['\n','\r\n']),Quote('"'))) ;


Layout_VA_all_available := record                          
   string BOARD;                
   string  OCCUPATION;          
   string  CERTIFICATE_NO;        
   string  INDIVIDUAL_NAME;     
   string  BUSINESS_NAME;       
   string  FIRST_LINE_ADDRESS;  
   string  SECOND_LINE_ADDRESS; 
   string  P_O_BOX_NO;            
   string  CITY;                
   string  STATE;               
   string  FIVE_DIGIT_ZIP_CODE; 
   string  ZIP_CODE_EXTENSION;  
   string PROVINCE;             
   string COUNTRY;              
   string  POSTAL_CODE;         
   string  EXPIRATION_DATE;     
   string  CERTIFICATION_DATE;  
   string  LICENSE_RANK;        
   string  LICENSE_SPECIALTY;   
   string  field19;             
   string lf;                   
end;                           
export all_available := dataset('~thor_data400::in::prolic::va::all_available::raw',Layout_VA_all_available,CSV( heading(1),separator('\t'),terminator(['\n','\r\n']),Quote('"'))) ;

end;