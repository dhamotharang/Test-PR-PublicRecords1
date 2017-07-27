IMPORT address, AID, BIPV2,HMS;

EXPORT layouts := MODULE

//	SHARED max_size := _Dataset().max_record_size;
	
	//===================================================
	//  Special Purpose Fields
	//===================================================

	EXPORT clean_address := RECORD
		address.Layout_Clean182.prim_range;
		address.Layout_Clean182.predir;
		address.Layout_Clean182.prim_name;
		address.Layout_Clean182.addr_suffix;
		address.Layout_Clean182.postdir;
		address.Layout_Clean182.unit_desig;
		address.Layout_Clean182.sec_range;
		address.Layout_Clean182.p_city_name;
		address.Layout_Clean182.v_city_name;
		address.Layout_Clean182.st;
		address.Layout_Clean182.zip;
		address.Layout_Clean182.zip4;
		address.Layout_Clean182.cart;
		address.Layout_Clean182.cr_sort_sz;
		address.Layout_Clean182.lot;
		address.Layout_Clean182.lot_order;
		address.Layout_Clean182.dbpc;
		address.Layout_Clean182.chk_digit;
		address.Layout_Clean182.rec_type;
		STRING2		fips_st:='';
		STRING3		fips_county:='';
		address.Layout_Clean182.geo_lat;
		address.Layout_Clean182.geo_long;
		address.Layout_Clean182.msa;
		address.Layout_Clean182.geo_blk;
		address.Layout_Clean182.geo_match;
		address.Layout_Clean182.err_stat;     
		AID.Common.xAID		RawAID;		
		AID.Common.xAID   ACEAID;         
	END;
	
	EXPORT clean_name	:= RECORD
		address.Layout_Clean_Name.fname;
		address.Layout_Clean_Name.mname;
		address.Layout_Clean_Name.lname;
		address.Layout_Clean_Name.name_suffix;
		STRING1 NameType:='';
		UNSIGNED8	nid;
	END;
		
	EXPORT src_and_date	:= RECORD
		STRING2 		src;		
		UNSIGNED4 	date_vendor_first_reported;
		UNSIGNED4 	date_vendor_last_reported;
		UNSIGNED4		date_first_seen	:= 0;
		UNSIGNED4		date_last_seen	:= 0;
		STRING1   	record_type;
		UNSIGNED8	 	source_rid;
		UNSIGNED8	 	lnpid;
	END;
	
	//===================================================
	//  IN FILES
	//===================================================

	EXPORT organization_in := record
		UNSIGNED8		LNFID;                    //NO01036469 100% 10  
		STRING86		NAME;                       //AFTEROURS HOUSTON PA 100% 86  
		STRING55		ADDRESS1;                   //7545 S BRAESWOOD BLVD 100% 55 Address Line 1 
		STRING19		ADDRESS2;                   //STE B 34.27% 19 Address Line 2 
		STRING28		CITY;                       //HOUSTON 100% 28 City 
		STRING30		STATE;                      //TX 99.99% 30 State 
		STRING12		ZIP;                        //77071 99.99% 12 Zip Code 5 
		STRING4 		ZIP4;                       //1423 96.15% 4 Zip Code Plus-4 
		STRING17		PHONE1;                     //7137776515 97.65% 17 Phone number 1 
		STRING17		PHONE2;                     //??            0% 0 Phone number 2 
		STRING17		FAX;                        //7137775544 41.17% 17 Fax number 
		STRING9 		LID;                        //5713126 100% 9  
		STRING9 		AGID;                       //5713121 100% 9  
		STRING5 		CBSA_CODE;                  //26420 95.25% 5  
		STRING10		LATITUDE;                   //29.674736 100% 10  
		STRING11		LONGITUDE;                  //-95.512017 100% 11  
		STRING19		FACTYPE;                    //OUTPATIENT FACILITY 98.05% 19 Facility Type 
		STRING7 		ORG_TYPE_CODE;              //1016010 98.05% 7  
		STRING60		ORGTYPE;                    //Outpatient Facility, Urgent Care Center 98.05% 60 Organization Type 
		STRING42		LN_GP_SPEC1;                //Family Practice 6.514% 42  
		STRING42		LN_GP_SPEC2;                //??             0% 0  
		STRING7 		NCPDP;                      //2135956 5.269% 7  
		STRING10		NPI;
		STRING1 		VENDIBILITY;                //N 100% 1  
	END;                         

	EXPORT affiliations_in := record
		UNSIGNED8		LNFID;  					//NO01036820 100% 10  
		STRING10		HMS_PIID; 				//PI8Q400624 99.29% 10 HMS Practitioner Unique Identifier 
		STRING13		FACTYPE;  				//Practice 100% 13 Facility Type 
	END;
		
	EXPORT aha_in_Old := record
		UNSIGNED8		LNFID; 					//NO00444937 100% 10  
		STRING10		AHA_ID;  					//Yale-NewHavenPsychiatricHospital-184LibertyStreet 100% 49 
	END;
	
	EXPORT aha_in := record
		STRING10		AHA_ID;
		STRING1			AHA_REGION_CODE;
		STRING1			AHA_STATE_CODE;
		STRING5			AHA_HOSPITAL_NUMBER;
		STRING10		DT_BEGIN_DATE;
		STRING2			DT_REPORT_BEGIN_MONTH;   	// Date Begin Month No.
		STRING2			DT_REPORT_BEGIN_DAY;   		// Date Begin Day No.
		STRING4			DT_REPORT_BEGIN_YEAR;   	// Date Begin Year
		STRING10		DT_END_DATE;   						// Date End
		STRING2			DT_REPORT_END_MONTH;   		// Date End Month No.
		STRING2			DT_REPORT_END_DAY;   			// Date End Day No.
		STRING4			DT_REPORT_END_YEAR;  		 	// Date End Year
		STRING4			DAYS_OPEN;								// Days open during reporting period
		STRING2			FISCAL_YEAR_PERIOD;				// Was the hospital in operation 12 full months to the end of the reporting period?
		STRING10		FISCAL_YEAR;							// Beginning date of fiscal year
		STRING2			FISCAL_MONTH;  					 	// Fiscal Year Beginning Month
		STRING2			FISCAL_DAY;   						// Fiscal Year Beginning Day
		STRING4			FISCAL_BEGIN_YEAR;   			// Fiscal Year Beginning Year
		STRING2			CONTROL_CODE;							// Control Code â€“ type of authority responsible for establishing policy concerning overall operation of the hospitals
		STRING2			SERVICE_CODE;							// Service Code â€“ category best describing the hospital of the type of service provided to the majority of admissions
		STRING			SERVICE_DESC;							// Special Service description
		STRING1			HOSP_REST_TO_CHILDREN;		// Does the hospital restrict admissions primarily to children?
		STRING1			SHORT_LONG_CODE;					// Short-term, long-term classification code 
		STRING1			HOSP_TYPE_CODE;						// Hospital type code
		STRING			HOSPITAL_NAME;						// Hospital name
		STRING			NAME_CHIEF_ADMINSTRATOR;	// Name of chief administrator 
		STRING			STREET_ADDRESS;						//Street address	
		STRING			CITY;
		STRING3			STATE_CODE;
		STRING10		ZIP_CODE;
		STRING2			STATE_ABBR;
		STRING3			AREA_CODE;
		STRING7			PHONE_NUMBER;
		STRING1			RESP_CODE;								// Response code
		STRING1			COMM_HOSPITAL_CODE;				// Community hospital code (as defined by AHA membership)
		STRING2			BED_SIZE_CODE;
		STRING1			SYSTEM_MEMBER;
		STRING1			SUBSIDARY_OPER;						// Does the hospital itself operate subsidiary corporations?
		STRING1			NPI;											// #N/A
		STRING10		NPI_NUMBER;								// 10 Digit NPI number
		STRING1			AHA_CLUSTER_CODE;					// AHA System Cluster Code
		STRING5			SYSTEM_ID;								// Health care system ID
		STRING			SYSTEM_NAME;							// 
		STRING			SYSTEM_ADDRESS;						
		STRING			SYSTEM_CITY;
		STRING2			SYSTEM_STATE;
		STRING10		SYSTEM_ZIP_CODE;
		STRING3			SYSTEM_AREA_CODE;
		STRING9			SYSTEM_TELEPHONE_NUMBER;
		STRING			SYSTEM_PRIMARY_CONTACT;
		STRING			SYSTEM_CONTACT_TITLE;
		STRING1			COMMUNITY_FLAG;						// Community Hospital flag - to foot to AHA Hospital Statisticsâ„¢
		STRING7			MEDICARE_PROVIDER_ID;
		STRING10		LATITUDE;
		STRING10		LONGITUDE;
		STRING			COUNTY_NAME;							// County Name, State Abbreviation
		STRING			CBSA_NAME;								// CBSA Name, State Abbreviation
		STRING7			CBSA_TYPE;
		STRING7			CBSA_CODE;
		STRING4			MODIFIED_FIPS_COUNTY_CODE;
		STRING5			FIPS_STATE_COUNTY_CODE;
		STRING3			FIPS_STATE_CODE;
		STRING3			FIPS_COUNTY_CODE;
		STRING3			CITY_RANKING;
		STRING1			ACCREDITATION;						// Accreditation by The Joint Commission 
		STRING1			CANCER_PROGRAM;						// Cancer program approved by American College of Surgeons
		STRING1			RESIDENCY_TRAINING;				// Residency training approval by Accreditation Council for Graduate Medical Education
		STRING1			MEDICAL_SCHOOL_AFFL;			// Medical school affiliation reported to American Medical Association
		STRING1			HOSP_CONTL;								// Hospital-controlled professional nursing school reported by National League for Nursing
		STRING1			ACCREDIATION_BY_COMMISION;// Accreditation by Commission on Accreditation of Rehabilitation Facilities (CARF)
		STRING1			MEMBER_OF_COUNCIL;				// Member of Council of Teaching Hospital of the Association of American Medical Colleges (COTH)
		STRING1			ACCREDIDATION_BY_HEALTHCARE;// Accreditation by Healthcare Facilities Accreditation Program (HFAP); American Osteopathic Association.
		STRING1			INTERNSHIP_APPROVED;			// Internship approved by American Osteopathic Association
		STRING1			RESIDENCY_APPROVED;				// Residency approved by American Osteopathic Association
		STRING1			CATHOLIC_CHRUCH_OPER;			// Catholic church operated
		STRING1			CRITICAL_ACCESS_HOSP;			// Critical Access Hospital
		STRING1			RURAL_REFERRAL_CENTER;		// Rural Referral Center
		STRING1			SOLE_COMMUNITY_PROVIDER;
		STRING15		Teach;										// #N/A
		STRING10		LNFID;
	END;

	EXPORT dea_in := record
		UNSIGNED8		LNFID;             			//NO01025441 100% 10  
		STRING9 		DEA;                 			//RZ0462200 100% 9 DEA Number 
		STRING8 		DEA_SCHEDULE;        			//2 33N 93.42% 15 DEA Number 
		STRING8 		DEA_EXPIRATION_DATE; 			//20160531 93.42% 8 DEA Number 
		STRING1			DEA_BUSINESS_ACT_CODE;    //G 93.42% 1 DEA Number 
		STRING1			DEA_BUSINESS_ACT_SUBCODE;  //2 93.42% 1 DEA Number 
	END;

	EXPORT npi_in := record
		UNSIGNED8		LNFID;    								//NO00950944 100% 10  
		STRING10		NPI;        								//1992999890 100% 10  
		STRING1 		NPI_STATUS; 								//Y 100% 1 
	END;

	EXPORT pos_in := record
		STRING10		Provider_Number;            //793834 100% 10 Medicare POS Facility Identifier 
		STRING			Facility_Name;
		STRING			ADDRESS;
		STRING			CITY;
		STRING2			STATE;
		STRING10		ZIP_CODE;
		STRING10		Phone;
		STRING1			Program_Terminaion_Code;
		UNSIGNED8		LNFID;           //NO00993054 100% 10  		
	END;

	EXPORT crosswalk_in := record
		UNSIGNED8		LNFID;          //NO01036838
		STRING10		SOURCE;           //NPI
		STRING10    PRIMARY_ID;				//1265419428
	END;

	//===================================================
	//  BASE FILES
	//===================================================
	EXPORT organization_base_Old := record
	  organization_in -[NPI];
		aha_in - [LNFID];
		dea_in - [LNFID];
		npi_in - [LNFID];
		pos_in - [LNFID];
		crosswalk_in - [LNFID];		
		src_and_date;
   	string50  prepped_addr1;  
   	string39  prepped_addr2;
		clean_address;
   	string10 	clean_prim_range;  //needed for macro - do not delete
   	string28 	clean_prim_name;   //needed for macro - do not delete
   	string2  	clean_st;			     //needed for macro - do not delete
   	string5  	clean_zip;		     //needed for macro - do not delete
   	string8  	clean_sec_range;   //needed for macro - do not delete
   	string10 	clean_phone;       //needed for macro - do not delete
   	string25 	clean_v_city_name; //needed for macro - do not delete

   	unsigned6 bdid;
   	unsigned1 bdid_score := 0; 
   	unsigned6 did 			:= 0;	

		BIPV2.IDlayouts.l_xlink_ids;
		
	END; 


	EXPORT organization_base := record
	  organization_in;
		aha_in - [LNFID];
		dea_in - [LNFID];
		npi_in - [LNFID];
		STRING10		Provider_Number;            //793834 100% 10 Medicare POS Facility Identifier 
		STRING			POS_Facility_Name;
		STRING			POS_ADDRESS;
		STRING			POS_CITY;
		STRING2			POS_STATE;
		STRING10		POS_ZIP_CODE;
		STRING10		POS_Phone;
		STRING1			POS_Program_Terminaion_Code;		
		crosswalk_in - [LNFID];		
		src_and_date;
		
		// these data items are needed for the macros
		
		// needed for clean_addr func/AID.MacAppendFromRaw_2Line macro
   	string50  prepped_addr1;  
   	string39  prepped_addr2;
		clean_address;
   	string10 	clean_prim_range;  //needed for macro - do not delete
   	string28 	clean_prim_name;   //needed for macro - do not delete
   	string2  	clean_st;			     //needed for macro - do not delete
   	string5  	clean_zip;		     //needed for macro - do not delete
   	string8  	clean_sec_range;   //needed for macro - do not delete
   	string10 	clean_phone;       //needed for macro - do not delete
   	string25 	clean_v_city_name; //needed for macro - do not delete

   	unsigned6 bdid;
   	unsigned1 bdid_score := 0; 
   	unsigned6 did 			:= 0;	

		BIPV2.IDlayouts.l_xlink_ids;
		
	END;                         

  EXPORT affiliations_base := record
	  affiliations_in;
		src_and_date;
	END;
		
	EXPORT aha_base := record
		UNSIGNED8 LNFID;
		STRING10 AHA_ID;	
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		
	  aha_in - [LNFID];
		STRING10 CLEAN_DT_BEGIN_DATE;
		STRING10 CLEAN_DT_END_DATE;
		STRING10 CLEAN_FISCAL_YEAR;
		src_and_date;
		//STRING35	clean_company_name;
		//STRING100	clean_Clinic_name;
		STRING10	clean_Phone;
		STRING70 	Prepped_Addr1;				// Address line1 & Line2 cat'ed
		STRING115 Prepped_Addr2;			// Address line1, 2, City, State, Zip5 cat'ed
		//STRING70 	Prepped_Sys_Addr1;				// Address line1 & Line2 cat'ed
		//STRING115 Prepped_Sys_Addr2;			// Address line1, 2, City, State, Zip5 cat'ed
		
		address.Layout_Clean182.prim_range;
		address.Layout_Clean182.predir;
		address.Layout_Clean182.prim_name;
		address.Layout_Clean182.addr_suffix;
		address.Layout_Clean182.postdir;
		address.Layout_Clean182.unit_desig;
		address.Layout_Clean182.sec_range;
		address.Layout_Clean182.p_city_name;
		address.Layout_Clean182.v_city_name;
		address.Layout_Clean182.st;
		address.Layout_Clean182.zip;
		address.Layout_Clean182.zip4;
		address.Layout_Clean182.cart;
		address.Layout_Clean182.cr_sort_sz;
		address.Layout_Clean182.lot;
		address.Layout_Clean182.lot_order;
		address.Layout_Clean182.dbpc;
		address.Layout_Clean182.chk_digit;
		address.Layout_Clean182.rec_type;
		string2					fips_st:='';
		string3					fips_county:='';
		address.Layout_Clean182.geo_lat;
		address.Layout_Clean182.geo_long;
		address.Layout_Clean182.msa;
		address.Layout_Clean182.geo_blk;
		address.Layout_Clean182.geo_match;
		address.Layout_Clean182.err_stat;
		AID.Common.xAID		RawAID;		
		AID.Common.xAID   ACEAID;
		BIPV2.IDlayouts.l_xlink_ids;
		
	END;

	EXPORT dea_base := record
		dea_in;
		src_and_date;
	END;

	EXPORT npi_base := record
		npi_in;
		src_and_date;
	END;

	EXPORT pos_base := record
		UNSIGNED8		LNFID;            		
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		
	  POS_in - [LNFID];
		src_and_date;
		STRING10	clean_Phone;
		STRING70 	Prepped_Addr1;				// Address line1 & Line2 cat'ed
		STRING115 Prepped_Addr2;				// Address line1, 2, City, State, Zip5 cat'ed
		
		address.Layout_Clean182.prim_range;
		address.Layout_Clean182.predir;
		address.Layout_Clean182.prim_name;
		address.Layout_Clean182.addr_suffix;
		address.Layout_Clean182.postdir;
		address.Layout_Clean182.unit_desig;
		address.Layout_Clean182.sec_range;
		address.Layout_Clean182.p_city_name;
		address.Layout_Clean182.v_city_name;
		address.Layout_Clean182.st;
		address.Layout_Clean182.zip;
		address.Layout_Clean182.zip4;
		address.Layout_Clean182.cart;
		address.Layout_Clean182.cr_sort_sz;
		address.Layout_Clean182.lot;
		address.Layout_Clean182.lot_order;
		address.Layout_Clean182.dbpc;
		address.Layout_Clean182.chk_digit;
		address.Layout_Clean182.rec_type;
		string2					fips_st:='';
		string3					fips_county:='';
		address.Layout_Clean182.geo_lat;
		address.Layout_Clean182.geo_long;
		address.Layout_Clean182.msa;
		address.Layout_Clean182.geo_blk;
		address.Layout_Clean182.geo_match;
		address.Layout_Clean182.err_stat;
		AID.Common.xAID		RawAID;		
		AID.Common.xAID   ACEAID;
		BIPV2.IDlayouts.l_xlink_ids;

	END;
		
	EXPORT crosswalk_base := record
		crosswalk_in;
		src_and_date;
	END;
	
	EXPORT Relationship_base := record		// crated based on advice from Mark Rhodes
			unsigned8 RID;				// Just a record ID for this table
			unsigned8	Src;				// 0 to begin with 
			string20	Id1;				// LNFID formatted to string to link back to incoming Affiliation file
			string1		ID1Type;		// 'F' refering to Id1 type, which is LNFID in this table	
			string20	Id2;				// HMS_PIID to link back to Org master/Facilities file
			string1		ID2Type;		// 'P' refering to Id2 type, which is LNPID in this table
			string10	Relationshiptype;		// Factype from incoming Affiliation file
			string8		EffectiveDate;			// Data Load date
			string8		ExpireDate;					// Blank to begin with
		END;

	// EXPORT Providers_Base := record
		// unsigned8	LNPID;				// From HMS.Individual_Base
		// string10	HMS_PIID;			// From HMS.Individual_Base
		// HMS.Layouts.Individual_Base-[LNPID, HMS_PIID]; 
	// END;	// Providers_Base
		
END;

