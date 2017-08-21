export Layout_File_CA_San_Diego_in := module

	export Sprayed := record
		string10 ORIG_FILING_NUMBER;
		string1 TYPE_OF_RECORD;
		string52 BUSINESS_NAME;
		//string(27) OWNER_NAME;
		string1 ABANDON_WITHDRAW_IND;
		string8 FILING_DATE;
		string8 ORIG_FILING_DATE;
		string10 NEW_FILING_NUMBER;
		string410 Filler;
		string2 crlf;
	end;
	
	export Cleaned := record
		string8  process_date;
		string10 ORIG_FILING_NUMBER;	
		string1  TYPE_OF_RECORD;	
		string52 BUSINESS_NAME;
		string27 OWNER_NAME;	
		string1  fbn_type;	
		string8  FILING_DATE         ;	
		string8  ORIG_FILING_DATE;	
		string10 NEW_FILING_NUMBER;
		string73 PNAME;
	end;

	//**** ABinitio cleaned layout to read the old prepprocessed file.
	export Cleaned_Old := record
		 string8  process_date;
		 string10 ORIG_FILING_NUMBER;	
		 string1  TYPE_OF_RECORD;	
		 string52 BUSINESS_NAME;
		 string27 OWNER_NAME;	
		 string1  fbn_type;	
		 string8  FILING_DATE         ;	
		 string8  ORIG_FILING_DATE;	
		 string10 NEW_FILING_NUMBER;
		 string73 PNAME;
	end;
end;
								 
								  