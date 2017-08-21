export Layouts_DL_CT_In := module
  // In  record lenght 194
	export Layout_CT_Update := record
		string2	  orig_DLSTATE;
		string9	  orig_DLNUMBER;
		string35  orig_NAME;
		string8	  orig_DOB;
		string1	  orig_SEX;
		string1	  orig_HEIGHT1;
		string2	  orig_HEIGHT2;
		string3	  orig_EYE_COLOR;
		string61  orig_MAILADDRESS;
		string6	  orig_CLASSIFICATION;
		string5	  orig_ENDORSEMENTS;
		string6	  orig_ISSUE_DATE;
		string2	  orig_ISSUE_DATE_DD;
		string6	  orig_EXPIRE_DATE;
		string2	  orig_EXPIRE_DATE_DD;
		string3	  orig_NONCDLSTATUS;
		string3	  orig_CDLSTATUS;
		string12  orig_RESTRICTIONS;
		string8	  orig_ORIGDATE;
		string8	  orig_ORIGCDLDATE;
		string2	  orig_CANCELST;
		string8	  orig_CANCELDATE;
		string1   orig_Filler;
		string2   orig_lf;
	end;
	
	export Layout_CT_With_ProcessDte := record
	    string8 Process_date;
		Layout_CT_Update;
	end;

  export Layout_CT_cleaned := record
	    string8 Process_date;
		Layout_CT_Update -orig_Filler;
		string73 temp_Clean_Name;
		string182 temp_Clean_Address;
	end;

end;