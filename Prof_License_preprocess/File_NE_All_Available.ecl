EXPORT File_NE_All_Available := module

Layout_ne := record                     
   string seq_number;      
   string continuation;    
   string  License_No;     
   string  Issue_Date;     
   string  Expiration_Date;
   string  Full_Name;      
   string  Last_Name;      
   string  First_Name;     
   string  Middle_Name;    
   string Name_Prefix;     
   string  Name_Suffix;    
   string  Address_line_1; 
   string  Add_Line_2;     
   string  Add_Line_3;     
   string  City;           
   string State;           
   string Zip;             
   string  County;         
   string  Status;         
   string  Profession;     
   string  License_Type;   
   string lf;              
end;                        


export raw := dataset('~thor_data400::in::prolic::ne::all_available::raw',Layout_ne,CSV( separator(','),terminator(['\n']),Quote('"')));
end;