export Layout_File_CA_Orange_in := module

	export Sprayed := Record									
			string REGIS_NBR           ;	
			string BUSINESS_LETTER     ;	
			string BUSINESS_NAME       ;	
			string ADDRESS             ;	
			string CITY                ;	
			string STATE               ;	
			string ZIP_CODE            ;	
			string PHONE_NBR           ;	
			string FILE_DATE           ;	
			string DOCETYEP						 ;	
			string OWNER_NBR           ;	
			string FIRST_NAME          ;	
			string MIDDLE_NAME         ;	
			string LAST_NAME_COMPANY   ;	
			string OWNER_ADDRESS       ;	
			string OWNER_CITY          ;	
			string OWNER_STATE         ;	
			string OWNER_ZIP_CODE      ;	
			string BUSINESS_TYPE			 ;			
	end;

	//**** ABinitio cleaned layout to read the old prepprocessed file.
	export cleaned_old := Record								
			string8 	process_date;
			string11 	REGIS_NBR           ;	
			string2 	BUSINESS_LETTER     ;	
			string100	BUSINESS_NAME       ;	
			string70 	ADDRESS             ;	
			string22 	CITY                ;	
			string4 	STATE               ;	
			string10 	ZIP_CODE            ;	
			string16 	PHONE_NBR           ;	
			string8 	FILE_DATE           ;	
			string6 	DOCETYEP;	
			string2 	OWNER_NBR           ;	
			string25 	FIRST_NAME          ;	
			string20 	MIDDLE_NAME         ;	
			string35 	LAST_NAME_COMPANY   ;	
			string70 	OWNER_ADDRESS       ;	
			string28 	OWNER_CITY          ;	
			string4 	OWNER_STATE         ;	
			string10 	OWNER_ZIP_CODE      ;	
			string4 	BUSINESS_TYPE;
			string182  	clean_business_address;
			string182  	clean_owner_address;
			string73    pname;
			string100  	cname;			
	end;
	
	export cleaned := Record									
			string8 	process_date;
			string11 	REGIS_NBR           ;	
			string2 	BUSINESS_LETTER     ;	
			string100	BUSINESS_NAME       ;	
			string70 	ADDRESS             ;	
			string22 	CITY                ;	
			string4 	STATE               ;	
			string10 	ZIP_CODE            ;	
			string16 	PHONE_NBR           ;	
			string8 	FILE_DATE           ;	
			string6 	DOCETYEP;	
			string2 	OWNER_NBR           ;	
			string25 	FIRST_NAME          ;	
			string20 	MIDDLE_NAME         ;	
			string35 	LAST_NAME_COMPANY   ;	
			string70 	OWNER_ADDRESS       ;	
			string28 	OWNER_CITY          ;	
			string4 	OWNER_STATE         ;	
			string10 	OWNER_ZIP_CODE      ;	
			string4 	BUSINESS_TYPE;
			//string182  	clean_business_address;
			//string182  	clean_owner_address;
			string100  prep_bus_addr_line1;
			string50   prep_bus_addr_line_last;
			string100  prep_owner_addr_line1;
			string50   prep_owner_addr_line_last;
			//string73	pname;
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			string3   name_score;
			string80	cname;			
	end;
	
end;
								
								