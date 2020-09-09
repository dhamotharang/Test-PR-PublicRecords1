EXPORT File_CT_All_Available := module

Layout_ct:= record                                
   string  License_Type;         
   string  License_Number;         
   string  Business_Name;                      
   string  Last_Name;                 
   string  First_Name;  
   string Middle_Name;
   string  Address_Line1;             
   string  Address_Line2;                                  
   string  City;                      
   string State;                      
   string  Zip_Code;                  
   string  County; 
   string Email;
   string Phone;
   string Fax;
   string Date_of_Birth;
   string Title;
   string Effective_Date;
   string Issue_Date;
   string Reinstate_Date;
   string Expiration_Date;
   string School;
   string Graduation_Date;
   string Status;
  string Reason;
  string Speciality;                
   string  lf;                        
end;
export raw := dataset('~thor_data400::in::prolic::ct::all_available::raw',Layout_ct,CSV( heading(1),separator('\t'),terminator(['\n']),Quote('"'))) ( trim(status) <> 'Status' );
end;