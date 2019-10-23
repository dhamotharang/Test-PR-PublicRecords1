EXPORT File_AL_Medical := module

Layout_PhyA_raw :=  record  
   string  First_Name;      
   string  Middle_Name;     
   string  Last_Name;       
   string Suffix;                           
   string License_Type;
	 string License_Sub_Type;
   string License_Number; 
   string  Address_1;       
   string  Address_2;       
   string  Address_3;       
   string  City;            
   string State;            
   string  Zip;
	 string  Telephone;  
   string Fax;
   string  Expiration_Date; 
	 string  Date_Issued;     
	 string Status; 
	 string HAS_QACSC;
   string QACSC_License_Type;
	 string QACSC_Number;
	 string QACSC_Issued;
	 string QACSC_Expiration;
	 string QACSC_Status;
	 string Schedule_III;
	 string Schedule_IIIN;
	 string Schedule_IV;
	 string Schedule_V;
    string HAS_LPSP;
   string LPSP_License_Type;
	 string LPSP_Number;
	 string LPSP_Issued;
	 string LPSP_Expiration;
	 string LPSP_Status;
	 string Schedule_II;
	 string Schedule_IIN;

   string lf;               
end;                         


export phya := dataset('~thor_data400::in::prolic::al::medical_exam::phys_assistant',Layout_PhyA_raw,CSV( heading(1),separator(','),terminator(['\n','\r\n']),Quote('"')));

Layout_Phys_raw := record
   string  First_Name;      
   string  Middle_Name;  
   string  Last_Name;       
   string Suffix;                           
   string License_Type; 
	 string License_Sub_Type;
   string License_Number; 
	 string Limited_Suffix;
   string  Address_1;       
   string  Address_2;       
   string  Address_3;       
   string  City;            
   string State;            
   string  Zip;
	 string  Telephone; 
	 string Fax;
	 string  Expiration_Date;
	 string  Date_Issued;     
	 string Status;  
	string HAS_ACSC;
   string QACSC_License;
	 string QACSC_Number;
	 string QACSC_Issued;
	 string QACSC_Expiration;
		 string QACSC_Status;
	 string Schedule_II;
	 string Schedule_IIN;
	 string Schedule_III;
	 string Schedule_IIIN;
	 string Schedule_IV;
	 string Schedule_V;
   string lf;                
end;                                


export phys := dataset('~thor_data400::in::prolic::al::medical_exam::physicians',Layout_Phys_raw,CSV( heading(1),separator(','),terminator(['\n','\r\n']),Quote('"')));



end;