EXPORT File_CA_All_Available := module

shared brz_rec := 
record                         
   string  Agency_Code;        
   string  Agency_Name;        
   string LicTypeCode;         
   string  License_Type;
   string License_Number;      
   string Indiv_Org;           
   string  Org_Last_Name;      
   string  First_Name;         
   string  Middle_Name;        
   string Suffix;              
   string  Address_Line_1;     
   string  Address_Line_2;     
   string  City;               
   string  County;             
   string State;               
   string  Zip;                
   string  Country;            
   string  Original_Issue_Date;
   string  Expiration_Date;    
   string  License_Status;     
   string lf;                  
end;                           

export brz00_raw := dataset('~thor_data400::in::prolic::ca::all_available::breeze',brz_rec,CSV( heading(1),separator(','),terminator(['\n']),Quote('"'))) ( trim(Address_Line_1) <> ' ' and regexfind('[0-9]',Zip) = true );

shared legacy_rec := record                         
   string  Agency_Name;        
   string  License_Type;       
   string  Speciality_Code;    
   string License_Number;      
   string Indiv_Org;           
   string  Org_Last_Name;      
   string  First_Name;         
   string  Middle_Name;        
   string Suffix;              
   string  Address_Line_1;     
   string  Address_Line_2;     
   string  City;               
   string  County;             
   string State;               
   string Zip;                 
   string  Country;            
   string  Original_Issue_Date;
   string  Expiration_Date;    
   string  School;             
   string Year_Graduated;      
   string  Degree;             
   string  License_Status;     
   string lf;                  
end;                            
                               
export lgc00_raw := dataset('~thor_data400::in::prolic::ca::all_available::legacy',legacy_rec,CSV( heading(1),separator(','),terminator(['\n']),Quote('"'))) ( trim(Address_Line_1) <> ' ' and regexfind('[0-9]',Zip) = true );


end;