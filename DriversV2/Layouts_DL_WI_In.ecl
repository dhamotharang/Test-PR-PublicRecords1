export Layouts_DL_WI_In := module

   //Vendor Update record lenght = 385
	export Layout_WI_Update_EBCDIC := record
	   ebcdic string2  orig_FILLER_START;
	   ebcdic string14 orig_DL_NUMBER;
	   ebcdic string30 orig_LAST_NAME;
	   ebcdic string15 orig_FIRST_NAME;
	   ebcdic string1  orig_MIDDLE_INITIAL;
	   ebcdic string1  orig_SEX;
	   ebcdic string8  orig_DOB;
	   ebcdic string16 orig_CITY;
	   ebcdic string40 orig_ADDRESS1;
	   ebcdic string40 orig_ADDRESS2;
	   ebcdic string5  orig_PO_BOX;
	   ebcdic string11 orig_COUNTY_NAME;
	   ebcdic string2  orig_STATE;
	   ebcdic string9  orig_ZIP_CODE;
	   ebcdic string1  orig_OPT_OUT_CODE;
	   ebcdic string1  orig_LICENSE_COUNTER;
	   ebcdic string4  orig_GROUP1_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP1_CLASSES;
	   ebcdic string6  orig_GROUP1_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP1_ISSUE_DATE;
	   ebcdic string8  orig_GROUP1_EXPIRATION_DATE;
	   ebcdic string4  orig_GROUP2_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP2_CLASSES;
	   ebcdic string6  orig_GROUP2_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP2_ISSUE_DATE;
	   ebcdic string8  orig_GROUP2_EXPIRATION_DATE;
	   ebcdic string4  orig_GROUP3_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP3_CLASSES;
	   ebcdic string6  orig_GROUP3_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP3_ISSUE_DATE;
	   ebcdic string8  orig_GROUP3_EXPIRATION_DATE;
	   ebcdic string4  orig_GROUP4_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP4_CLASSES;
	   ebcdic string6  orig_GROUP4_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP4_ISSUE_DATE;
	   ebcdic string8  orig_GROUP4_EXPIRATION_DATE;
	   ebcdic string4  orig_GROUP5_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP5_CLASSES;
	   ebcdic string6  orig_GROUP5_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP5_ISSUE_DATE;
	   ebcdic string8  orig_GROUP5_EXPIRATION_DATE;
	   ebcdic string4  orig_GROUP6_LICENSE_TYPE;
	   ebcdic string5  orig_GROUP6_CLASSES;
	   ebcdic string6  orig_GROUP6_ENDORSEMENTS;
	   ebcdic string8  orig_GROUP6_ISSUE_DATE;
	   ebcdic string8  orig_GROUP6_EXPIRATION_DATE;
	   ebcdic string3  orig_FILLER_END;
	end;
	
	export Layout_WI_With_ProcessDte := record
		string8 process_date;
		Layout_WI_Update_EBCDIC;
	end; 


 //Vendor Update record lenght = 385
	export Layout_WI_Update := record
	   string2  orig_FILLER_START;
	   string14 orig_DL_NUMBER;
	   string30 orig_LAST_NAME;
	   string15 orig_FIRST_NAME;
	   string1  orig_MIDDLE_INITIAL;
	   string1  orig_SEX;
	   string8  orig_DOB;
	   string16 orig_CITY;
	   string40 orig_ADDRESS1;
	   string40 orig_ADDRESS2;
	   string5  orig_PO_BOX;
	   string11 orig_COUNTY_NAME;
	   string2  orig_STATE;
	   string9  orig_ZIP_CODE;
	   string1  orig_OPT_OUT_CODE;
	   string1  orig_LICENSE_COUNTER;
	   string4  orig_GROUP1_LICENSE_TYPE;
	   string5  orig_GROUP1_CLASSES;
	   string6  orig_GROUP1_ENDORSEMENTS;
	   string8  orig_GROUP1_ISSUE_DATE;
	   string8  orig_GROUP1_EXPIRATION_DATE;
	   string4  orig_GROUP2_LICENSE_TYPE;
	   string5  orig_GROUP2_CLASSES;
	   string6  orig_GROUP2_ENDORSEMENTS;
	   string8  orig_GROUP2_ISSUE_DATE;
	   string8  orig_GROUP2_EXPIRATION_DATE;
	   string4  orig_GROUP3_LICENSE_TYPE;
	   string5  orig_GROUP3_CLASSES;
	   string6  orig_GROUP3_ENDORSEMENTS;
	   string8  orig_GROUP3_ISSUE_DATE;
	   string8  orig_GROUP3_EXPIRATION_DATE;
	   string4  orig_GROUP4_LICENSE_TYPE;
	   string5  orig_GROUP4_CLASSES;
	   string6  orig_GROUP4_ENDORSEMENTS;
	   string8  orig_GROUP4_ISSUE_DATE;
	   string8  orig_GROUP4_EXPIRATION_DATE;
	   string4  orig_GROUP5_LICENSE_TYPE;
	   string5  orig_GROUP5_CLASSES;
	   string6  orig_GROUP5_ENDORSEMENTS;
	   string8  orig_GROUP5_ISSUE_DATE;
	   string8  orig_GROUP5_EXPIRATION_DATE;
	   string4  orig_GROUP6_LICENSE_TYPE;
	   string5  orig_GROUP6_CLASSES;
	   string6  orig_GROUP6_ENDORSEMENTS;
	   string8  orig_GROUP6_ISSUE_DATE;
	   string8  orig_GROUP6_EXPIRATION_DATE;
	   string3  orig_FILLER_END;
		 string1  orig_LF;
	end;
	
	export Layout_WI_With_ProcessDte2 := record
		string8 process_date;
		Layout_WI_Update;
	end; 
end;