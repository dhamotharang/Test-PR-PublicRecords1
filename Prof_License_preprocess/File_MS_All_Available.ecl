EXPORT File_MS_All_Available  := module

Layout_ms := record                           
   string  Whole_License_Number; 
   string  Last_Name;            
   string  First_Name;
	 string  License_Type;         
   string  License_Status;      
   string  Home_Address_1;       
   string  Home_City;            
   string  Home_State;           
   string Home_Zip;              
   string  Original_Issued_Date; 
   string  License_Expires;      
   string lf;                    
end;                             


export raw := dataset('~thor_data400::in::prolic::ms::available::raw',Layout_ms,CSV( separator(','),terminator(['\n']),Quote('"'))) ( trim(Whole_License_Number) <> 'Whole License Number' );
end;