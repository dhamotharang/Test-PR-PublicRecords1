import address,AID;

export Layout_6510_Government_Debarred_Contractor_In_AID :=	record
	string8 process_date;
	string10 FILE_NUMBER;
	string4 SEGMENT_CODE;
	string5 SEQUENCE_NUMBER;
	string6 orig_DATE_FILED_YYMMDD;
	string6 orig_DATE_REPORTED_YYMMDD;
	string2 ACTION_CODE;
	string10 ACTION_DESC;
	string40 CO_BUS_NAME;
	string30 CO_BUS_ADDRESS;
	string13 CO_BUS_CITY;
	string2 CO_BUS_STATE_CODE;
	string20 CO_BUS_STATE_DESC;
	string5 CO_BUS_ZIP;
	string15 EXTENT_OF_ACTION;
	string5 AGENCY_CODE;
	string40 AGENCY_DESC;
	string1 DISPUTE_IND;
	string2 DISPUTE_CODE;
	string8 date_filed;
	string8 date_reported;
	AID.Common.xAID	Append_RawAID;
	AID.Common.xAID	Append_ACEAID;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;
	Address.Layout_Clean_Name clean_business_name;
end;