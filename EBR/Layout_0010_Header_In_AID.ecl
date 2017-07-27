import address, AID;

export Layout_0010_Header_In_AID :=	record
	string8		process_date;
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string8		orig_EXTRACT_DATE_MDY;
	string6		orig_FILE_ESTAB_DATE_MMYY;
	string1		FILE_ESTAB_FLAG;
	string40	COMPANY_NAME;
	string30	STREET_ADDRESS;
	string28	CITY;
	string2		STATE_CODE;
	string20	STATE_NAME;
	string5		orig_ZIP;
	string4		orig_ZIP_4;
	string10	PHONE_NUMBER;
	string4		SIC_CODE;
	string40	BUSINESS_DESC;
	string1		DISPUTE_IND;
	string8		extract_date;
	string6		file_estab_date;
	AID.Common.xAID	Append_RawAID;
	AID.Common.xAID	Append_ACEAID;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;
end;	