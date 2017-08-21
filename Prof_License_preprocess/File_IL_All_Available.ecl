EXPORT File_IL_All_Available := module

Layout_il := record                                
   string  Credential_Prefix;         
   string  Credential_Number;         
   string  Name;                      
   string  Last_Name;                 
   string  First_Name;                
   string  Business_Name;             
   string Status;                     
   string  City;                      
   string State;                      
   string  Zip_Code;                  
   string  County;                    
   string  Attention_Line;            
   string  Address_Line1;             
   string  Address_Line2;             
   string  Has_Been_Disciplined;      
   string  License_Issuance_Date;     
   string  License_Expiration_Date;                                         
   string  lf;                        
                                      
end;

export raw := dataset('~thor_data400::in::prolic::il::all_available::raw',Layout_il,CSV( heading(1),separator(','),terminator(['\n']),Quote('"'))) ( trim(status) <> 'Status' );
end;