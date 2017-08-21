// UTS0683 / Utah Division of Real Estate / Multiple Professions //

export layout_UTS0683 := MODULE
	export raw := RECORD
	string50   PROF;
	string10   PROF_ID;
	string60   LICENSE_NAME;
	string10   LIC_TYPE;
	string20   LICENSE_NO;
	string 		 LICENSE_STATUS;
	string150  SORT_NAME;  					// format LFM
	string100  NAME;    						// Same FML format of SORT_NAME field
	string20   ISSUE_DATE;
	string20   EXP_DATE;
	string50   ADDR_LINE_1;
	string50   ADDR_LINE_2;
	string25   ADDR_CITY;
	string15   ADDR_STATE;
	string15   ADDR_ZIPCODE;
	string30   COUNTY;
	string15   ADDR_PHONE;
	string100	 ASSOCIATION;
	string12	 ASSOC_LICENSE_NO;
	string12	 BROKER_LICENSE_NO;
END;

	export src := RECORD
	raw;
	string8	ln_filedate;
	
end;

END;	


