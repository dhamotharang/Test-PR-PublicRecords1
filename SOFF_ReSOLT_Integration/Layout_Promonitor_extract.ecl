export Layout_Promonitor_extract := RECORD, MAXLENGTH(4096)
    string50   EXTERNAL_ID;
	//	INTEGER4	 SSN;
	  String9	   SSN;
    string2    DOB_MONTH;
    string2    DOB_DAY;
		string4    DOB_YEAR;
		string50   FIRST_NAME;
		string50   MIDDLE_NAME;
		string50   LAST_NAME;
		string50   STREET_1;
		string50   STREET_2;
		string50   STREET_3;
		string50   CITY;
		string2    STATE;
		string5    POSTAL_CODE;
		string11   ACCOUNT_ID;
		string20   USERNAME;
		string1    OPERATION_TYPE;
		string50   REFERENCE_ID;
		string50   DL_NUM;
		string2    DL_STATE;
		unsigned8  LINK_ID;
 end;

