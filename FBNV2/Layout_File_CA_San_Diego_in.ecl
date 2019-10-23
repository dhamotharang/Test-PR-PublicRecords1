export Layout_File_CA_San_Diego_in := module

	export Sprayed := record
		string FILE_NUMBER;
		string FILE_DATE;
		string EXPIRATION_DATE;
		string PREV_FILE_NUMBER;
		string PREV_FILE_DATE;
		string FILING_TYPE;
		string BUSINESS_START_DATE;
		string OWNERSHIP_TYPE;
		string BUSINESS_NAME;
    string TYPE_OF_NAME;
		string TYPE_OF_NAME_SEQ_NUM;
		string STREET_ADDRESS1;
		string STREET_ADDRESS2;
		string CITY;
		string STATE;
		string ZIP_CODE;
		string COUNTRY;
		string MAILING_ADDRESS1;
		string MAILING_ADDRESS2;
		string MAILING_CITY;
		string MAILING_STATE;
		string MAILING_ZIP_CODE;
		string MAILING_COUNTRY;
	end;
	
	export Cleaned := record
	  string8   process_date;
		string1   TYPE_OF_RECORD;	       //exists only in old layout
		string27  OWNER_NAME;	           //exists only in old layout
		string1   fbn_type;	             //exists only in old layout
		string73  PNAME;                 //exists only in old layout
		string12  FILE_NUMBER;           //NEW_FILING_NUMBER in old layout
		string8   FILE_DATE;             //FILING_DATE in old layout
		string8   EXPIRATION_DATE;
		string12  PREV_FILE_NUMBER;      //ORIG_FILING_NUMBER in old layout
		string8   PREV_FILE_DATE;        //ORIG_FILING_DATE in old layout
		string3   FILING_TYPE;
		string8   BUSINESS_START_DATE;
		string3   OWNERSHIP_TYPE;
		string150 BUSINESS_NAME;         //BUSINESS_NAME in old layout
    string1   TYPE_OF_NAME;
		string2   TYPE_OF_NAME_SEQ_NUM;
		string150 STREET_ADDRESS1;
		string150 STREET_ADDRESS2;
		string50  CITY;
		string50  STATE;
		string50  ZIP_CODE;
		string50  COUNTRY;
		string150 MAILING_ADDRESS1;
		string150 MAILING_ADDRESS2;
		string50  MAILING_CITY;
		string50  MAILING_STATE;
		string50  MAILING_ZIP_CODE;
		string50  MAILING_COUNTRY;
		string300	prep_addr_line1;
		string50	prep_addr_line_last;
		string300	prep_mail_addr_line1;
		string50	prep_mail_addr_line_last;

	end;

end;
								 
								  