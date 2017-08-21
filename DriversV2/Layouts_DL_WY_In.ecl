export Layouts_DL_WY_In := module

	export Layout_WY_Update := record
		string20 orig_LAST_NAME; 
		string12 orig_FIRST_NAME; 
		string12 orig_MIDDLE_NAME; 
		string25 mailing_STREET_ADDR_1;
		string21 mailing_CITY_1; 
		string2	 mailing_STATE_1; 
		string5	 mailing_ZIP_CODE_1; 
		string25 orig_STREET_ADDR_2;
		string21 orig_CITY_2; 
		string2	 orig_STATE_2; 
		string5	 orig_ZIP_CODE_2; 
		string9	 orig_DL_NUMBER; 
		string8	 orig_DOB; 
		string1	 orig_CODE_1; 
		string1	 orig_CODE_2; 
		string1	 orig_CODE_3; 
		string1	 orig_CODE_4; 
		string1	 orig_CODE_5; 
		string1	 orig_CODE_6; 
		string1	 orig_CODE_7;
		string1	 orig_CODE_8; 
		string8	 orig_ISSUE_DATE; 
		string8	 orig_EXPIRE_DATE;
		string1  orig_lf;
	end;
	
	export Layout_WY_With_ProcessDte := record
	  string8 Process_date;
		Layout_WY_Update;
	end;

  export Layout_WY_MedCert_Update := record
		string20 orig_LAST_NAME; 
		string12 orig_FIRST_NAME; 
		string12 orig_MIDDLE_NAME; 
		string25 mailing_STREET_ADDR_1;
		string21 mailing_CITY_1; 
		string2	 mailing_STATE_1; 
		string5	 mailing_ZIP_CODE_1; 
		string25 phys_STREET_ADDR_2;
		string21 phys_CITY_2; 
		string2	 phys_STATE_2; 
		string5	 phys_ZIP_CODE_2; 
		string9	 orig_DL_NUMBER; 
		string8	 orig_DOB; 
		string1	 orig_CODE_1; 
		string1	 orig_CODE_2; 
		string1	 orig_CODE_3; 
		string1	 orig_CODE_4; 
		string1	 orig_CODE_5; 
		string1	 orig_CODE_6; 
		string1	 orig_CODE_7;
		string1	 orig_CODE_8; 
		string8	 orig_ISSUE_DATE; 
		string8	 orig_EXPIRE_DATE;
    string1  Med_Cert_Status;
		string2  Med_Cert_Type;
		string8  Med_Cert_Expire_Date;
		string1  orig_lf;
	end;
	
	export Layout_WY_MedCert_With_ProcessDte := record
	  string8 Process_date;
		Layout_WY_MedCert_Update;
	end;
	
	export Layout_WY_MedCert_Cleaned := record
   	string8	  append_PROCESS_DATE;
   	string20  orig_LAST_NAME; 
		string12  orig_FIRST_NAME; 
		string12  orig_MIDDLE_NAME; 
		string25  mailing_STREET_ADDR_1;
		string21  mailing_CITY_1; 
		string2	  mailing_STATE_1; 
		string5	  mailing_ZIP_CODE_1; 
		string25  phys_STREET_ADDR_2;
		string21  phys_CITY_2; 
		string2	  phys_STATE_2; 
		string5	  phys_ZIP_CODE_2; 
		string9	  orig_DL_NUMBER; 
		string8	  orig_DOB; 
		string1	  orig_CODE_1; 
		string1	  orig_CODE_2; 
		string1	  orig_CODE_3; 
		string1	  orig_CODE_4; 
		string1	  orig_CODE_5; 
		string1	  orig_CODE_6; 
		string1	  orig_CODE_7;
		string1	  orig_CODE_8; 
		string8	  orig_ISSUE_DATE; 
		string8	  orig_EXPIRE_DATE;
    string1   Med_Cert_Status;
		string2   Med_Cert_Type;
		string8   Med_Cert_Expire_Date;
		string5   name_suffix;
   	string5	  clean_name_prefix;
   	string20  clean_name_first;
   	string20  clean_name_middle;
   	string20  clean_name_last;
   	string5	  clean_name_suffix;
   	string3		clean_name_score;
  end;
	
	export Layout_WY_MedCert_Temp := record
   	string8	  append_PROCESS_DATE;
   	string20  orig_LAST_NAME; 
		string12  orig_FIRST_NAME; 
		string12  orig_MIDDLE_NAME; 
		string25  STREET_ADDR;
		string21  CITY; 
		string2	  STATE; 
		string5	  ZIP_CODE; 
		string9	  orig_DL_NUMBER; 
		string8	  orig_DOB; 
		string1	  orig_CODE_1; 
		string1	  orig_CODE_2; 
		string1	  orig_CODE_3; 
		string1	  orig_CODE_4; 
		string1	  orig_CODE_5; 
		string1	  orig_CODE_6; 
		string1	  orig_CODE_7;
		string1	  orig_CODE_8; 
		string8	  orig_ISSUE_DATE; 
		string8	  orig_EXPIRE_DATE;
    string1   Med_Cert_Status;
		string2   Med_Cert_Type;
		string8   Med_Cert_Expire_Date;
		string5   name_suffix;
   	string5	  clean_name_prefix;
   	string20  clean_name_first;
   	string20  clean_name_middle;
   	string20  clean_name_last;
   	string5	  clean_name_suffix;
   	string3		clean_name_score;
  end;
	
	export Layout_WY_CP := record
	  string10	DL_NUMBER; 
		string20  LAST_NAME; 
		string15  FIRST_NAME; 
		string15  MIDDLE_NAME; 
		string10  DOB;
		string3   ACD_Code;       // Adverse action
		string10  Conv_Code;      // Adverse action
		string40  Conv_Desc;      // Adverse action
		string7   Entrd_Sys_Date;
		string10  Offense_Date;
		string10  Conviction_Date;
		string10  Advrse_Actn_Str_Date;
		string10  Advrse_Actn_End_Date;
		string1   Record_Type;
		string1   Lf;
	end;
	
	export Layout_WY_CP_With_ProcessDte := record
	  string8 Process_date;
		Layout_WY_CP -LF;
	end;
	
	export Layout_WY_CP_Cln := record
    Layout_WY_CP_With_ProcessDte;
		string5   name_suffix := '';
   	string5	  clean_name_prefix;
   	string20  clean_name_first;
   	string20  clean_name_middle;
   	string20  clean_name_last;
   	string5	  clean_name_suffix;
	end;
end;