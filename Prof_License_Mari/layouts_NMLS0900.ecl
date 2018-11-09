//Nationwide Mortgage Licensing System Professional Licenses Files for MARI

export layouts_NMLS0900 := module

	export Branch := 
		RECORD
			integer 	BRANCH_NMLS_ID,
			integer 	COMPANY_NMLS_ID,
			string300 NAME,
			string50  STREET1,
			string50 	STREET2,
			string50  CITY,
			string20  STATE,
			string16 	ZIPCODE,
			string50  COUNTRY,
			string3  	IS_AUTHORIZED,
	END;
	
	export Branch_Lic := 
		RECORD
			integer 	BRANCH_NMLS_ID,
			string500 REGULATOR,
			integer 	LICENSE_ID,
			string50  LICENSE_NBR,
			string500 LICENSE_TYPE,
			string10 	ORIG_ISSUE_DATE,
			string500 STATUS,
			string10 	EFFECTIVE_DATE,					//status date
			string3  	IS_AUTHORIZED_LICENSE,
			string4		RENEW_THRU,
	END;

	export Branch_DBA := 
		RECORD
			integer 	BRANCH_NMLS_ID,
			string500 REGULATOR,
			string150 DBA,
			string21	NAME_TYPE,
	END;

	export  Business := 
		RECORD
			integer 	COMPANY_NMLS_ID,
			string150 NAME,
			string50  STREET1,
			string50  STREET2,
			string50  CITY,
			string20  STATE,
			string16  ZIPCODE,
			string50  COUNTRY,
			string500	FEDREGULATOR,
			string20	FEDSTATUS,
			string50	BUSINESS_STRUCTURE,
			string10 FISCALYEAREND,     //New field
			string50 FORMEDIN,         //New field 
			string10 DATEFORMED,         //New field
			string4 STOCKSYMBOL,       //DF-12096
	END;

export Business_Lic := 
		RECORD
			integer 	COMPANY_NMLS_ID,
			string500 REGULATOR,
			integer 	LICENSE_ID,
			string50  LICENSE_NBR,
			string500 LICENSE_TYPE,
			string  	ORIG_ISSUE_DATE,
			string500 STATUS,
			string10 	EFFECTIVE_DATE,
			string3  	IS_AUTHORIZED_LICENSE,
			string4		RENEW_THRU	
	END;

	export Business_DBA := 
		RECORD
			integer 	COMPANY_NMLS_ID,
			string500 REGULATOR,
			string150 DBA,
			string21	NAME_TYPE  //DF-20827 Layout change
	END;

	export Individual := 
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string50  FIRST_NAME,
			string50	MIDDLE_NAME,
			string50  LAST_NAME,
			string10  SUFFIX,
	END;
	
export Individual_Lic := 
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string500 REGULATOR,
			integer 	LICENSE_ID,
			string50  LICENSE_NBR,
			string500 LICENSE_TYPE,
			string  	ORIG_ISSUE_DATE,
			string500 STATUS,
			string10 	EFFECTIVE_DATE,
			string3  	IS_AUTHORIZED_LICENSE,
			string4		RENEW_THRU,
	END;

	export Individual_Location :=
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string150	COMPANY,
			integer 	LOCATION_NMLS_ID,
			string6		LOCATION_TYPE,
			string101 STREET1,
//			string  STREET2,
			string50  CITY,
			string20  STATE,
			string16  ZIPCODE,
			string50  COUNTRY,
			string10	START_DATE,
	END;
	
	export Individual_AKA	:= 
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string50  FIRST_NAME,
			string50  MIDDLE_NAME,
			string50  LAST_NAME,
			string10  SUFFIX,
			string10	NAME_TYPE,
	END;
	
	export Indv_Registration	:= 
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string60  REGNAME,
			string10	STATUS,
			string5  	IS_REG_AUTHORIZED,
	END;
	
	export	Indv_RegDetail	:=
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			string150	EMPLOYER_NAME,
			string150	INSTIT_NAME,
			integer		INSTIT_NMLS_ID,
			string500	FEDREGULATOR,
			string10  START_DATE,
			string10 	END_DATE,
	END;	 
		
	
	export Sponsorship :=
		RECORD
			integer 	INDIVIDUAL_NMLS_ID,
			integer 	COMPANY_NMLS_ID,
			string150	COMPANY,
			string500	REGULATOR,
			integer 	LICENSE_ID,
			string500 LICENSE_TYPE,
			string10 	START_DATE,
			string10 	END_DATE,
	END;
	
	
		export Regulatory :=
		RECORD
			integer 	STATE_ACTION_ID,
			integer		NMLS_ID,
			string20 	ENTITY_TYPE,
			string500	REGULATOR,
			string70 	ACTION_TYPE,
			string10 	ACTION_DATE,
			string20  MULTI_STATE_ACTION_ID,
			string40  DOCKET_NUMBER,
			STRING100	URL,
	END;
	
	
		export Individual_Disciplinary_Action :=
		RECORD
			integer			Individual_NMLS_ID,
			string500		AUTHORITY_TYPE,
			string500		ACTION_TYPE,
			string10 		ACTION_DATE,
			string500		NAME_AUTHORITY,
			string4000	ACTION_DETAIL,
			STRING200		URL,
			integer 		STATE_ACTION_ID,
	END;
	
END;