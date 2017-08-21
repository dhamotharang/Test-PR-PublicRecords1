export Layout_File_TX_Harris_in := module

  export InstrumentSprayed := record
		string7  FILE_NUMBER;	
		string9  FILM_CODE;	
		string8  DATE_FILED;
		string2  NUM_PAGES; //NEW
		string2  TERM;
		string1  EXPIRED_TERM; //NEW
		string1  INCORPORATED; //NEW
		string1  ASSUMED_NAME; //NEW
	end;
	
	export OwnerSprayed := record
		string7  FILE_NUMBER;	
		string60 NAME2;	
		string30 STREET_ADD2;	
		string20 CITY2;	
		string2  STATE2;	
		string9  ZIP2;	
	end;
	
	export DbasSprayed := record
		string7  FILE_NUMBER;	
		string60 NAME1;	
		string30 STREET_ADD1;	
		string20 CITY1;	
		string2  STATE1;	
		string9  ZIP1;	
	end;
	
	// New input format
	export combinedSprayed := record
	/*
   Missing fields from old sprayed:
	   RECORD_TYPE
     BUS_TYPE;	
		 ANNEX_CODE
   */
		InstrumentSprayed;
		OwnerSprayed - FILE_NUMBER;
		DbasSprayed - FILE_NUMBER;
	end;

  // Old input format
	export Sprayed := record
		string7  FILE_NUMBER;	
		string1  RECORD_TYPE;	
		string60 NAME1;	
		string30 STREET_ADD1;	
		string20 CITY1;	
		string2  STATE1;	
		string9  ZIP1;	
		string2  TERM;	
		string60 NAME2;	
		string30 STREET_ADD2;	
		string20 CITY2;	
		string2  STATE2;	
		string9  ZIP2;	
		string9  FILM_CODE;	
		string8  DATE_FILED;	
		string1  BUS_TYPE;	
		string1  ANNEX_CODE;	
		string2  lf; 
	end;

	export Cleaned := record
		string8   Process_date;
		string7 	FILE_NUMBER;	
		string1 	RECORD_TYPE;	
		string60 	NAME1;	
		string30 	STREET_ADD1;	
		string20 	CITY1;	
		string2 	STATE1;	
		string9 	ZIP1;	
		string2 	TERM;	
		string60 	NAME2;	
		string30 	STREET_ADD2;	
		string20 	CITY2;	
		string2 	STATE2;	
		string9 	ZIP2;	
		string9 	FILM_CODE;	
		string8 	DATE_FILED;	
		string1 	BUS_TYPE;	
		string1 	ANNEX_CODE;	
		string2   NUM_PAGES; //NEW
		string1   EXPIRED_TERM; //NEW
		string1   INCORPORATED; //NEW
		string1   ASSUMED_NAME; //NEW
		string100 prep_addr1_line1;
		string50	prep_addr1_line_last;
		string100 prep_addr2_line1;
		string50	prep_addr2_line_last;
		string5   name1_title;
		string20  name1_fname;
		string20  name1_mname;
		string20  name1_lname;
		string5   name1_name_suffix;
		string3   name1_name_score;
		string5   name2_title;
		string20  name2_fname;
		string20  name2_mname;
		string20  name2_lname;
		string5   name2_name_suffix;
		string3   name2_name_score;
	end;

	export Cleaned_Old := record
		string8   Process_date;
		string7 	FILE_NUMBER;	
		string1 	RECORD_TYPE;	
		string60 	NAME1;	
		string30 	STREET_ADD1;	
		string20 	CITY1;	
		string2 	STATE1;	
		string9 	ZIP1;	
		string2 	TERM;	
		string60 	NAME2;	
		string30 	STREET_ADD2;	
		string20 	CITY2;	
		string2 	STATE2;	
		string9 	ZIP2;	
		string9 	FILM_CODE;	
		string8 	DATE_FILED;	
		string1 	BUS_TYPE;	
		string1 	ANNEX_CODE;	
		string182	clean_address;
		string73	pname;
		string182	clean_address1;
		string73	pname1;
	end;
end;