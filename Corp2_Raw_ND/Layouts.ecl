EXPORT Layouts := module
	
	EXPORT FilingLayoutIn:= RECORD
	  string SOS_CONTROL_ID;
		string FILING_TYPE;
		string BUSINESS_TYPE;
	  string DURATION_TYPE;
	  string STATUS;
	  string STANDING_AR;
	  string STANDING_RA;
	  string FILING_NAME;
	  string FILING_DATE;
	  string DELAYED_EFFECTIVE_DATE;
	  string EXPIRATION_DATE;
	  string INACTIVE_DATE;
	  string FORMATION_LOCALE;
	  string FORM_HOME_JURIS_DATE;
	  string PRINCIPLE_ADDR1;
	  string PRINCIPLE_ADDR2;
	  string PRINCIPLE_ADDR3;
	  string PRINCIPLE_CITY;
	  string PRINCIPLE_STATE;
	  string PRINCIPLE_POSTAL_CODE;
	  string PRINCIPLE_COUNTRY;
	  string MAIL_ADDR1;
	  string MAIL_ADDR2;
	  string MAIL_ADDR3;
	  string MAIL_CITY;
	  string MAIL_STATE;
	  string MAIL_POSTAL_CODE;
	  string MAIL_COUNTRY;
	  string RA_NAME;
	  string RA_PRINCIPLE_ADDR1;
	  string RA_PRINCIPLE_ADDR2;
	  string RA_PRINCIPLE_ADDR3;
	  string RA_PRINCIPLE_CITY;
	  string RA_PRINCIPLE_STATE;
	  string RA_PRINCIPLE_POSTAL_CODE;
	  string RA_PRINCIPLE_COUNTRY;
	  string RA_MAIL_ADDR1;
	  string RA_MAIL_ADDR2;
	  string RA_MAIL_ADDR3;
	  string RA_MAIL_CITY;
	  string RA_MAIL_STATE;
	  string RA_MAIL_POSTAL_CODE;
	  string RA_MAIL_COUNTRY;
	  string PURPOSE;
	END;
	
	EXPORT OwnerLayoutIn:= RECORD
		string SOS_CONTROL_ID;
		string FILING_TYPE;
		string FILING_NAME;
		string NAME;
		string FIRST_NAME;
		string MIDDLE_NAME;
		string LAST_NAME;
		string MAIL_ADDR1;
		string MAIL_ADDR2;
		string MAIL_ADDR3;
		string MAIL_CITY;
		string MAIL_STATE;
		string MAIL_POSTAL_CODE;
		string MAIL_COUNTRY;
	END;
	
	EXPORT TMLayoutIn:= RECORD
	  string SOS_CONTROL_ID;
		string TRADEMARK_NAME;
		string STATUS;
		string FILING_DATE;
		string EXPIRATION_DATE;
		string INACTIVE_DATE;
		string FORMATION_LOCALE;
		string OWNER;
		string MAIL_ADDR1;
		string MAIL_ADDR2;
		string MAIL_ADDR3;
		string MAIL_CITY;
		string MAIL_STATE;
		string MAIL_POSTAL_CODE;
		string MAIL_COUNTRY;
		string APPLICANT_TYPE;
	END;
	
  EXPORT TMClassLayoutIn:= RECORD
	  string SOS_CONTROL_ID;
		string CLASS_NAME;
	END;
	
  EXPORT Temp_TrademarkWithClass:= RECORD
			TMLayoutIn;
			TMClassLayoutIn.CLASS_NAME;
			string class1;
			string class2;
			string class3;
			string class4;
			string class5;
			string class6;
	END;
	
END;
