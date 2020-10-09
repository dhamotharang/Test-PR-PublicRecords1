﻿import AID,standard,BIPV2, dx_common;

export layouts := MODULE
	export Mari_in := RECORD
		 UNSIGNED8	PRIMARY_KEY;
		 STRING19	CREATE_DTE;
		 STRING19	LAST_UPD_DTE;
		 STRING19	STAMP_DTE;
		 STRING10	GEN_NBR;
		 STRING3	STD_PROF_CD;
		 STRING5	STD_SOURCE_UPD;
		 STRING2	TYPE_CD;
		 STRING10	NAME_ORG_PREFX;
		 STRING80	NAME_ORG;
		 STRING15	NAME_ORG_SUFX;
		 STRING10	STORE_NBR;
		 STRING10	NAME_DBA_PREFX;
		 STRING80	NAME_DBA;
		 STRING15	NAME_DBA_SUFX;
		 STRING10	STORE_NBR_DBA;
		 INTEGER1	DBA_FLAG;
		 STRING80	NAME_OFFICE;
		 STRING2	OFFICE_PARSE;
		 STRING8	NAME_PREFX;
		 STRING30	NAME_FIRST;
		 STRING30	NAME_MID;
		 STRING50	NAME_LAST;
		 STRING5	NAME_SUFX;
		 STRING15	NAME_NICK;
		 STRING2	DOB_MM;
		 STRING2	DOB_DD;
		 STRING4	DOB_YYYY;
		 STRING1	GENDER;
		 STRING1	PROV_STAT;
		 STRING14	CREDENTIAL;
		 STRING30	LICENSE_NBR;
		 STRING18	OFF_LICENSE_NBR;
		 STRING2	LICENSE_STATE;
		 STRING10	STD_LICENSE_TYPE;
		 STRING3	STD_LICENSE_STATUS;
		 STRING19	CURR_ISSUE_DTE;
		 STRING19	ORIG_ISSUE_DTE;
		 STRING19	EXPIRE_DTE;
		 STRING6	ACTIVE_FLAG;
		 STRING9	SSN_TAXID_1;
		 STRING1	TAX_TYPE_1;
		 STRING9	SSN_TAXID_2;
		 STRING1  TAX_TYPE_2;
		 STRING8	FED_RSSD;
		 UNSIGNED1 ADDR_BUS_IND_1;
		 UNSIGNED1 ADDR_MAIL_IND_1;
		 UNSIGNED1 ADDR_HOME_IND_1;
		 STRING254	NAME_ORG_ORIG;
		 STRING254 NAME_DBA_ORIG;
		 STRING80	NAME_MARI_ORG;
		 STRING80	NAME_MARI_DBA;
		 STRING15	PHN_MARI_1;
		 STRING15	PHN_MARI_FAX_1;
		 STRING15	PHN_MARI_2;
		 STRING15	PHN_MARI_FAX_2;
		 STRING10	ADDR_ID_1;
		 STRING50	ADDR_ADDR1_1;
		 STRING50	ADDR_ADDR2_1;
		 STRING25	ADDR_CITY_1;
		 STRING2	ADDR_STATE_1;
		 STRING5	ADDR_ZIP5_1;
		 STRING4	ADDR_ZIP4_1;
		 STRING10	PHN_PHONE_1;
		 STRING10	PHN_FAX_1;
		 STRING35	ADDR_CNTY_1;
		 STRING25	ADDR_CNTRY_1;
		 STRING5	SUD_KEY_1;
		 UNSIGNED1	OOC_IND_1;
		 STRING2	RESULT_CD_1;
		 STRING4	ADDR_CARRIER_RTE_1;
		 STRING3	ADDR_DELIVERY_PT_1;
		 UNSIGNED1 ADDR_BUS_IND_2;
		 UNSIGNED1 ADDR_MAIL_IND_2;
		 UNSIGNED1 ADDR_HOME_IND_2;
		 STRING10	ADDR_ID_2;
		 STRING50	ADDR_ADDR1_2;
		 STRING50	ADDR_ADDR2_2;
		 STRING25	ADDR_CITY_2;
		 STRING2	ADDR_STATE_2;
		 STRING5	ADDR_ZIP5_2;
		 STRING4	ADDR_ZIP4_2;
		 STRING35	ADDR_CNTY_2;
		 STRING25	ADDR_CNTRY_2;
		 STRING10	PHN_PHONE_2;
		 STRING10	PHN_FAX_2;
		 STRING5	SUD_KEY_2;
		 UNSIGNED1	OOC_IND_2;
		 STRING2	RESULT_CD_2;
		 STRING5	ADDR_CARRIER_RTE_2;
		 STRING3	ADDR_DELIVERY_PT_2;
		 STRING15	LICENSE_NBR_CONTACT;
		 STRING8	NAME_CONTACT_PREFX;
		 STRING15	NAME_CONTACT_FIRST;
		 STRING15	NAME_CONTACT_MID;
		 STRING30	NAME_CONTACT_LAST;
		 STRING3	NAME_CONTACT_SUFX;
		 STRING15	NAME_CONTACT_NICK;
		 STRING40	NAME_CONTACT_TTL;
		 STRING10	PHN_CONTACT;
		 STRING6	PHN_CONTACT_EXT;
		 STRING10	PHN_CONTACT_FAX;
		 STRING80	EMAIL;
		 STRING80	URL;
		 STRING7	BK_CLASS;
		 STRING7	CHARTER;
		 STRING10	INST_BEG_DTE;
		 STRING1	ORIGIN_CD;
		 STRING5	DISP_TYPE_CD;
		 STRING7	REG_AGENT;
		 STRING22	HQTR_CITY;
		 STRING95	HQTR_NAME;
		 STRING6	DOMESTIC_OFF_NBR;
		 STRING5	FOREIGN_OFF_NBR;
		 STRING7	HCR_RSSD;
		 STRING8	HCR_LOCATION;
		 STRING2	AFFIL_TYPE_CD;
		 STRING10	GENLINK;
		 UNSIGNED1	RESEARCH_IND;
		 STRING6	DOCKET_ID;
		 UNSIGNED8 REC_KEY;
		 UNSIGNED8 MLTRECKEY;
		 UNSIGNED8 OLD_CMC_SLPK;
		 UNSIGNED8 CMC_SLPK;
		 UNSIGNED8 PCMC_SLPK;
		 UNSIGNED8 AFFIL_KEY;
		 STRING15	MATCH_ID;
		 STRING  	PROVNOTE_1;
		 STRING		PROVNOTE_2;
		 STRING		PROVNOTE_3
END;

export base :=  RECORD,maxlength(8000)
				UNSIGNED8		PRIMARY_KEY,
		    STRING19 		CREATE_DTE,                  // fmt YYYYMMDD 
		    STRING19		LAST_UPD_DTE,                // fmt YYYYMMDD 
		    STRING19		STAMP_DTE,                   // fmt YYYYMMDD {DATA DATE}
				STRING8			DATE_FIRST_SEEN,
				STRING8			DATE_LAST_SEEN,
				STRING8 		DATE_VENDOR_FIRST_REPORTED,
				STRING8			DATE_VENDOR_LAST_REPORTED,
				STRING8			PROCESS_DATE,
				STRING10		GEN_NBR,
		    STRING3			STD_PROF_CD,			  	 			 // TRANSLATION VIA CMVTRANSLATION REFERENCE FILE
				STRING40  	STD_PROF_DESC,               // TRANSLATION VIA CMVPROF REFERENCE FILE
		    STRING5			STD_SOURCE_UPD,
				STRING85  	STD_SOURCE_DESC,             // TRANSLATION VIA CMVSRCE REFERENCE FILE
		    STRING2			TYPE_CD,                     // VALID ENTRY- GR:CORPORATION,GROUPS, OR CLINICS; MD:INDIVIDUAL
		    STRING10		NAME_ORG_PREFX,
		    STRING80		NAME_ORG,
		    STRING15		NAME_ORG_SUFX,
		    STRING10		STORE_NBR,
		    STRING10		NAME_DBA_PREFX,
		    STRING80		NAME_DBA,
		    STRING15		NAME_DBA_SUFX,
		    STRING10		STORE_NBR_DBA,
		    INTEGER1		DBA_FLAG,                  // VALID ENTRY- 1:TRUE, 0:FALSE
		    STRING80		NAME_OFFICE,
		    STRING2			OFFICE_PARSE,
		    STRING8			NAME_PREFX,
		    STRING30		NAME_FIRST,
		    STRING30		NAME_MID,
		    STRING50		NAME_LAST,
		    STRING5			NAME_SUFX,
				STRING15		NAME_NICK,                    // AKA NAME(NICKNAME)
				STRING8			BIRTH_DTE,					  				// fmt YYYYMMDD
		    STRING1			GENDER,                       // VALID ENTRY- M:MALE, F:FEMALE, U:UNKNOWN
				STRING1			PROV_STAT,                    // VALID ENTRY- D:DECEASED, R:RETIRED
		    STRING14		CREDENTIAL,
		    STRING30		LICENSE_NBR,
		    STRING18		OFF_LICENSE_NBR,
				STRING20  	PREV_LICENSE_NBR,
				STRING20  	PREV_LICENSE_TYPE,
		    STRING2			LICENSE_STATE,
				STRING100  	RAW_LICENSE_TYPE,			  			// VENDOR LICENSE TYPE -- PLOTN
				STRING10  	STD_LICENSE_TYPE,             // TRANSLATION VIA CMVTRANSLATION REFERENCE FILE
		    STRING120  	STD_LICENSE_DESC,             // TRANSLATION VIA CMVLICTYPE REFERENCE FILE
				STRING75  	RAW_LICENSE_STATUS,           // VENDOR LICENSE STATUSE -- PLOTN
				STRING3   	STD_LICENSE_STATUS,			  		// TRANSLATION VIA CMVTRANSLATION REFERENCE FILE
				STRING120		STD_STATUS_DESC,              // TRANSLATION VIA CMVLICSTATUS REFERENCE FILE
				STRING8  		CURR_ISSUE_DTE,	    		  		// fmt YYYYMMDD
		    STRING8 		ORIG_ISSUE_DTE,               // fmt YYYYMMDD
		    STRING8 		EXPIRE_DTE,                   // fmt YYYYMMDD
				STRING8   	RENEWAL_DTE,                  // fmt YYYYMMDD
		    STRING6			ACTIVE_FLAG,
		    STRING9			SSN_TAXID_1,
		    STRING1			TAX_TYPE_1,                   // VALID ENTRY- S:SSN, E:EIN
		    STRING9			SSN_TAXID_2,
				STRING1   	TAX_TYPE_2,                   // VALID ENTRY- S:SSN, E:EIN
		    STRING8			FED_RSSD,
		    STRING1			ADDR_BUS_IND,                 // VALID ENTRY- B:BUSINESS
				STRING1			NAME_FORMAT,									// VALID ENTRY- L:LAST, FIRST, MIDDLE; F:FIRST,MIDDLE, LAST, SUFFIX
		    STRING254		NAME_ORG_ORIG,
		    STRING254		NAME_DBA_ORIG,
		    STRING80		NAME_MARI_ORG,
		    STRING80		NAME_MARI_DBA,
		    STRING15		PHN_MARI_1,
		    STRING15		PHN_MARI_FAX_1,
		    STRING15		PHN_MARI_2,
				STRING15		PHN_MARI_FAX_2,
		    STRING50		ADDR_ADDR1_1,
		    STRING50		ADDR_ADDR2_1,
				STRING50  	ADDR_ADDR3_1,
				STRING50  	ADDR_ADDR4_1,
		    STRING25		ADDR_CITY_1,
		    STRING2			ADDR_STATE_1,
		    STRING5			ADDR_ZIP5_1,
		    STRING4			ADDR_ZIP4_1,
		    STRING10		PHN_PHONE_1,
		    STRING10		PHN_FAX_1,
		    STRING35		ADDR_CNTY_1,
		    STRING25		ADDR_CNTRY_1,
		    STRING5			SUD_KEY_1,
		    INTEGER1		OOC_IND_1,                    // VALID ENTRY- 1:TRUE, 0:FALSE
		    STRING1			ADDR_MAIL_IND,                // VALUE ENTRY- M:MAIL
		    STRING50		ADDR_ADDR1_2,
		    STRING50		ADDR_ADDR2_2,
				STRING50  	ADDR_ADDR3_2,
				STRING50  	ADDR_ADDR4_2,
		    STRING25		ADDR_CITY_2,
		    STRING2			ADDR_STATE_2,
		    STRING5			ADDR_ZIP5_2,
		    STRING4			ADDR_ZIP4_2,
		    STRING35		ADDR_CNTY_2,
		    STRING25		ADDR_CNTRY_2,
		    STRING10		PHN_PHONE_2,
		    STRING10		PHN_FAX_2,
		    STRING5			SUD_KEY_2,
		    INTEGER1		OOC_IND_2,                   // VALID ENTRY- 1:TRUE, 0:FALSE
		    STRING15		LICENSE_NBR_CONTACT,
		    STRING8			NAME_CONTACT_PREFX,
		    STRING15		NAME_CONTACT_FIRST,
		    STRING15		NAME_CONTACT_MID,
		    STRING30		NAME_CONTACT_LAST,
		    STRING3			NAME_CONTACT_SUFX,
				STRING15		NAME_CONTACT_NICK,
		    STRING40		NAME_CONTACT_TTL,
		    STRING10		PHN_CONTACT,
		    STRING6			PHN_CONTACT_EXT,
		    STRING10		PHN_CONTACT_FAX,
		    STRING80		EMAIL,
		    STRING80		URL,
		    STRING7			BK_CLASS,                    // VALID ENTRY- N, SM, NM, SB, SA, OR OI  
				STRING75  	BK_CLASS_DESC,               
		    STRING7			CHARTER,
		    STRING10		INST_BEG_DTE,                // fmt YYYYMMDD
			  STRING1			ORIGIN_CD,                   // VIA CMVTRANSLATION REFERENCE FILE; VALID ENTRY- D, E, G, L, O, W, R, OR BLANK 
				STRING35  	ORIGIN_CD_DESC,           
		    STRING5			DISP_TYPE_CD,                // VIA CMVTRANSLATION REFERENCE FILE; VALID ENTRY- C, D, L, O, P, Q, R, OR V
				STRING250  	DISP_TYPE_DESC,
				STRING7			REG_AGENT,
				STRING150  	REGULATOR,									 // populated by NMLS
			  STRING22		HQTR_CITY,
		    STRING95		HQTR_NAME,
		    STRING6			DOMESTIC_OFF_NBR,
		    STRING5			FOREIGN_OFF_NBR,
		    STRING7			HCR_RSSD,
		    STRING8			HCR_LOCATION,
		    STRING2			AFFIL_TYPE_CD,                // VALID ENTRY- CO:COMPANY, BR:BRANCH, IN:INDIVIDUAL
		    STRING10		GENLINK,
		    INTEGER1		RESEARCH_IND,
		    STRING6			DOCKET_ID,									
			  UNSIGNED8 	MLTRECKEY,									// Groups records together when additional records are created to handle multiple DBAs
				UNSIGNED8 	CMC_SLPK,										// Primekey for license record			
				UNSIGNED8 	PCMC_SLPK,									// Primekey for license of parent company(Main)
				UNSIGNED8 	AFFIL_KEY,
				STRING  		PROVNOTE_1,
				STRING			PROVNOTE_2,
				STRING			PROVNOTE_3,
				STRING1     ACTION_TAKEN_IND,
				STRING8     VIOL_TYPE,
				STRING50    VIOL_CD,
				STRING200   VIOL_DESC,
				STRING8     VIOL_DTE,                     // fmt YYYYMMDD
				STRING50    VIOL_CASE_NBR,
				STRING8     VIOL_EFF_DTE,                 // fmt YYYYMMDD
				STRING30    ACTION_FINAL_NBR,
				STRING30    ACTION_STATUS,
				STRING8     ACTION_STATUS_DTE,            // fmt YYYYMMDD
				STRING500  	DISPLINARY_ACTION,
				STRING100   ACTION_FILE_NAME,
				STRING50    OCCUPATION,
				STRING20    PRACTICE_HRS,
				STRING50    PRACTICE_TYPE,
				STRING50    MISC_OTHER_ID,
				STRING10    MISC_OTHER_TYPE,
				STRING50		CONT_EDUCATION_ERND,
				STRING60		CONT_EDUCATION_REQ,
				STRING10		CONT_EDUCATION_TERM,
				// STRING75    CONT_EDUCATION,
				STRING30    SCHL_ATTEND_1,
				STRING15    SCHL_ATTEND_DTE_1,
				STRING25		SCHL_CURRICULUM_1,
				STRING15    SCHL_DEGREE_1,
				STRING30    SCHL_ATTEND_2,
				STRING15    SCHL_ATTEND_DTE_2,
				STRING25		SCHL_CURRICULUM_2,
				STRING15    SCHL_DEGREE_2,
        STRING30    SCHL_ATTEND_3,
				STRING15    SCHL_ATTEND_DTE_3,
				STRING25		SCHL_CURRICULUM_3,
				STRING15    SCHL_DEGREE_3,
				STRING75    ADDL_LICENSE_SPEC,
				STRING5     PLACE_BIRTH_CD,
				STRING25    PLACE_BIRTH_DESC,
				STRING5     RACE_CD,
				STRING5     STD_RACE_CD,			 	   					// VALID ENTRY: ALEU:ALEUTIAN, API:ASIAN/PACIFIC IS., BLK:BLACK/AFRICAN AMERICAN, ESK: ALSSKAN NATIVE, HISP:HISPANIC, JPN:JAPANESE, MIX:MIXED, NAAM:NATIVE AMERICAN INDIAN, OTH:OTHER(S), UNK:UNKNOWN, WHT:WHITE/CAUCASIAN,   
				STRING25    RACE_DESC,
				STRING8     STATUS_EFFECT_DTE,             	// fmt YYYYMMDD; 
				STRING8     STATUS_RENEW_DESC,
				STRING20    AGENCY_STATUS,									// populated by NMLS- Federal Regulator Status
				UNSIGNED8 	PREV_PRIMARY_KEY,
				UNSIGNED8 	PREV_MLTRECKEY,
				UNSIGNED8 	PREV_CMC_SLPK,
				UNSIGNED8 	PREV_PCMC_SLPK,
				UNSIGNED8		LICENSE_ID,										// Populated by NMLS 
				UNSIGNED8		NMLS_ID,											// Populated by NMLS (COMPANY, BRANCH, INDIVIDUAL)
				UNSIGNED8		FOREIGN_NMLS_ID,							// Populated by NMLS (COMPANY, LOCATION)
				STRING6			LOCATION_TYPE,								// populated by NMLS 
				STRING50		OFF_LICENSE_NBR_TYPE,					// Identify OFF_LICENSE_NBR(Officer, Corporation, Broker)
				STRING30		BRKR_LICENSE_NBR,							// Broker License, Employing Broker's License 
				STRING50		BRKR_LICENSE_NBR_TYPE,				// Associated Broker License, 
				STRING30		AGENCY_ID,
				STRING60		SITE_LOCATION,
				STRING50		BUSINESS_TYPE,
				STRING10		NAME_TYPE,											// Populated by NMLS
				STRING8			START_DTE,											// Populated by NMLS
				STRING3			is_Authorized_License,					// Populated by NMLS
				STRING3			is_Authorized_Conduct,					// Populated by NMLS
				STRING150		FEDERAL_REGULATOR,							// Populated by NMLS
				//DF-28229 Add Delta build fields
				dx_common.layout_metadata;				
				
      END;  


		export intermediate :=	RECORD
				UNSIGNED6		MARI_RID;
				UNSIGNED8		PRIMARY_KEY;
		    STRING8			CREATE_DTE;			
		    STRING8 		LAST_UPD_DTE;		
		    STRING8			STAMP_DTE;			
				STRING8			DATE_FIRST_SEEN;
				STRING8			DATE_LAST_SEEN;
				STRING8 		DATE_VENDOR_FIRST_REPORTED;
				STRING8			DATE_VENDOR_LAST_REPORTED;
				STRING8			PROCESS_DATE;
		    STRING10		GEN_NBR;
				STRING3			STD_PROF_CD;
		    STRING40		STD_PROF_DESC;
		    STRING5			STD_SOURCE_UPD;
				STRING80  	STD_SOURCE_DESC; 
		    STRING2			TYPE_CD;
		    STRING10		NAME_ORG_PREFX;
		    STRING80		NAME_ORG;
		    STRING15		NAME_ORG_SUFX;
		    STRING10		STORE_NBR;
		    STRING10		NAME_DBA_PREFX;
		    STRING80		NAME_DBA;
		    STRING15		NAME_DBA_SUFX;
		    STRING10		STORE_NBR_DBA;
		    UNSIGNED1		DBA_FLAG;
		    STRING80		NAME_OFFICE;
		    STRING2			OFFICE_PARSE;
		    STRING8			NAME_PREFX;
		    STRING30		NAME_FIRST;
		    STRING30		NAME_MID;
		    STRING50		NAME_LAST;
		    STRING5			NAME_SUFX;
		    STRING15		NAME_NICK;
		    STRING8			BIRTH_DTE;						
				STRING1			GENDER;
		    STRING1			PROV_STAT;
		    STRING14		CREDENTIAL;
		    STRING30		LICENSE_NBR;
		    STRING30		OFF_LICENSE_NBR;
				STRING50		OFF_LICENSE_NBR_TYPE;					// Identify OFF_LICENSE_NBR(Officer, Corporation, Broker)
				STRING30		BRKR_LICENSE_NBR;							// Broker License, Associated Broker License, Employing Broker's License 
				STRING50		BRKR_LICENSE_NBR_TYPE;
		    STRING2			LICENSE_STATE;
				STRING100  	RAW_LICENSE_TYPE,
		    STRING10		STD_LICENSE_TYPE;
				STRING120		STD_LICENSE_DESC;
				STRING75  	RAW_LICENSE_STATUS,
		    STRING3			STD_LICENSE_STATUS;
				STRING120		STD_STATUS_DESC;
		    STRING8			CURR_ISSUE_DTE;				
		    STRING8			ORIG_ISSUE_DTE;				
		    STRING8			EXPIRE_DTE;	
				STRING8			RENEWAL_DTE;
		    STRING6			ACTIVE_FLAG;
		    STRING9			SSN_TAXID_1;
		    STRING1			TAX_TYPE_1;
		    STRING9			SSN_TAXID_2;
				STRING1   	TAX_TYPE_2;
		    STRING8			FED_RSSD;
		    STRING1			ADDR_BUS_IND;
				STRING1			NAME_FORMAT;		
		    STRING254		NAME_ORG_ORIG;
		    STRING254		NAME_DBA_ORIG;
		    STRING254		NAME_MARI_ORG;				//increased from 80 to 254
		    STRING254		NAME_MARI_DBA;				//increased from 80 to 254
		    STRING15		PHN_MARI_1;
		    STRING15		PHN_MARI_FAX_1;
		    STRING15		PHN_MARI_2;
		    STRING15		PHN_MARI_FAX_2;
		    STRING10		ADDR_ID_1;
		    STRING50		ADDR_ADDR1_1;
		    STRING50		ADDR_ADDR2_1;
		    STRING25		ADDR_CITY_1;
		    STRING2			ADDR_STATE_1;
		    STRING5			ADDR_ZIP5_1;
		    STRING4			ADDR_ZIP4_1;
		    STRING10		PHN_PHONE_1;
		    STRING10		PHN_FAX_1;
		    STRING35		ADDR_CNTY_1;
		    STRING25		ADDR_CNTRY_1;
		    STRING5			SUD_KEY_1;
		    UNSIGNED1		OOC_IND_1;
		    STRING2			RESULT_CD_1;
		    STRING4			ADDR_CARRIER_RTE_1;
		    STRING3			ADDR_DELIVERY_PT_1;
		    STRING1			ADDR_MAIL_IND;
		    STRING10		ADDR_ID_2;
		    STRING50		ADDR_ADDR1_2;
		    STRING50		ADDR_ADDR2_2;
		    STRING25		ADDR_CITY_2;
		    STRING2			ADDR_STATE_2;
		    STRING5			ADDR_ZIP5_2;
		    STRING4			ADDR_ZIP4_2;
		    STRING35		ADDR_CNTY_2;
		    STRING25		ADDR_CNTRY_2;
		    STRING10		PHN_PHONE_2;
		    STRING10		PHN_FAX_2;
		    STRING5			SUD_KEY_2;
		    UNSIGNED		OOC_IND_2;
		    STRING2			RESULT_CD_2;
		    STRING5			ADDR_CARRIER_RTE_2;
		    STRING3			ADDR_DELIVERY_PT_2;
		    STRING15		LICENSE_NBR_CONTACT;
		    STRING8			NAME_CONTACT_PREFX;
		    STRING15		NAME_CONTACT_FIRST;
		    STRING15		NAME_CONTACT_MID;
		    STRING30		NAME_CONTACT_LAST;
		    STRING3			NAME_CONTACT_SUFX;
		    STRING15		NAME_CONTACT_NICK;
		    STRING40		NAME_CONTACT_TTL;
		    STRING10		PHN_CONTACT;
		    STRING6			PHN_CONTACT_EXT;
		    STRING10		PHN_CONTACT_FAX;
		    STRING80		EMAIL;
		    STRING80		URL;
		    STRING7			BK_CLASS;
				STRING75  	BK_CLASS_DESC;               
			  STRING7			CHARTER;
			  STRING10		INST_BEG_DTE;
			  STRING1			ORIGIN_CD;
				STRING35  	ORIGIN_CD_DESC, 
			  STRING5			DISP_TYPE_CD;
				STRING250  	DISP_TYPE_DESC;
				STRING7			REG_AGENT;
				STRING150  	REGULATOR;									 // populated by NMLS
			  STRING22		HQTR_CITY;
		    STRING95		HQTR_NAME;
		    STRING6			DOMESTIC_OFF_NBR;
		    STRING5			FOREIGN_OFF_NBR;
		    STRING7			HCR_RSSD;
		    STRING8			HCR_LOCATION;
		    STRING2			AFFIL_TYPE_CD;
		    STRING10		GENLINK;
		    UNSIGNED1		RESEARCH_IND;
		    STRING6			DOCKET_ID;
			  UNSIGNED8 	REC_KEY;
		    UNSIGNED8 	MLTRECKEY;
				UNSIGNED8 	OLD_CMC_SLPK;
		    UNSIGNED8 	CMC_SLPK;
				UNSIGNED8 	PCMC_SLPK;
		    UNSIGNED8 	AFFIL_KEY;
		    STRING15		MATCH_ID;
				STRING 			PROVNOTE_1;
				STRING 			PROVNOTE_2;
				STRING 			PROVNOTE_3;
				UNSIGNED8 	PREV_PRIMARY_KEY;
				UNSIGNED8 	PREV_MLTRECKEY;
				UNSIGNED8 	PREV_CMC_SLPK;
				UNSIGNED8 	PREV_PCMC_SLPK;
				UNSIGNED8 	PERSISTENT_RECORD_ID;
				STRING75    ADDL_LICENSE_SPEC,
				STRING50		CONT_EDUCATION_ERND;
				STRING60		CONT_EDUCATION_REQ;
				STRING10		CONT_EDUCATION_TERM;
				STRING30		AGENCY_ID;
				STRING60		SITE_LOCATION;
				STRING50		BUSINESS_TYPE;
				STRING500  	DISPLINARY_ACTION;
				STRING8			VIOLATION_DTE;
				STRING50		VIOLATION_CASE_NBR;
				STRING200		VIOLATION_DESC;
				UNSIGNED8		LICENSE_ID,										// Populated by NMLS 
				UNSIGNED8		NMLS_ID,											// Populated by NMLS (COMPANY, BRANCH, INDIVIDUAL)
				UNSIGNED8		FOREIGN_NMLS_ID,							// Populated by NMLS (COMPANY, LOCATION)
				STRING6			LOCATION_TYPE;								// populated by NMLS 
				STRING11		NAME_TYPE;										// Populated by NMLS (OTHER, PRIOROTHER,PRIORLEGAL)
				STRING8			START_DTE;										// Populated by NMLS
				STRING20  	AGENCY_STATUS;								// populated by NMLS- Federal Regulator Status
				STRING3			is_Authorized_License;				// Populated by NMLS
				STRING3			is_Authorized_Conduct;				// Populated by NMLS
				STRING150		FEDERAL_REGULATOR;						// Populated by NMLS				
				//BIP Section
				BIPV2.IDlayouts.l_xlink_ids; 
				//DF-28229 Add Delta build fields
				dx_common.layout_metadata;								
			END;  
			
	export clean :=	RECORD
				intermediate;
				UNSIGNED6	DID			:= 0;
				UNSIGNED6	BDID		:= 0;
				STRING5		TITLE;
				STRING20	FNAME;
				STRING20	MNAME;
				STRING20	LNAME;
				STRING5		NAME_SUFFIX;
				STRING254 NAME_COMPANY;
				STRING254	NAME_COMPANY_DBA;
				STRING100					Append_BusAddrFirst;
				STRING50					Append_BusAddrLast;
				AID.Common.xAID		Append_BusRawAID;
				AID.Common.xAID		Append_BusAceAID;			
				STRING100					Append_MailAddrFirst;
				STRING50					Append_MailAddrLast;
				AID.Common.xAID		Append_MailRawAID;
				AID.Common.xAID		Append_MailAceAID;	
		END;
		
	export final := RECORD
				clean - dx_common.layout_metadata;
				string10	BUS_PRIM_RANGE;
				string2   BUS_PREDIR;
				string28	BUS_PRIM_NAME;
				string4   BUS_ADDR_SUFFIX;
				string2   BUS_POSTDIR;
				string10  BUS_UNIT_DESIG;
				string8		BUS_SEC_RANGE;
				string30  BUS_P_CITY_NAME;   	// increase length to accommodate Canadian City
				string25  BUS_V_CITY_NAME;
				string2		BUS_STATE;
				string6		BUS_ZIP5;						// increase length to accommodate Canadian Zip
				string4   BUS_ZIP4;
				string4   BUS_CART;
				string1   BUS_CR_SORT_SZ;
				string4   BUS_LOT;
				string1   BUS_LOT_ORDER;
				string2   BUS_DPBC;
				string1   BUS_CHK_DIGIT;
				string2   BUS_REC_TYPE;
				STRING2   BUS_ACE_FIPS_ST;
				string3   BUS_COUNTY;
				string10  BUS_GEO_LAT;
				string11  BUS_GEO_LONG;
				string4   BUS_MSA;
				string7   BUS_GEO_BLK;
				string1   BUS_GEO_MATCH;
				string5   BUS_ERR_STAT;  			// increase length to accommodate Canadian err_stat
				string10	MAIL_PRIM_RANGE;
				string2   MAIL_PREDIR;
				string28	MAIL_PRIM_NAME;
				string4   MAIL_ADDR_SUFFIX;
				string2   MAIL_POSTDIR;
				string10  MAIL_UNIT_DESIG;
				string8		MAIL_SEC_RANGE;
				string30  MAIL_P_CITY_NAME;   	// increase length to accommodate Canadian City
				string25  MAIL_V_CITY_NAME;
				string2		MAIL_STATE;
				string6		MAIL_ZIP5;						// increase length to accommodate Canadian Zip
				string4   MAIL_ZIP4;
				string4   MAIL_CART;
				string1   MAIL_CR_SORT_SZ;
				string4   MAIL_LOT;
				string1   MAIL_LOT_ORDER;
				string2   MAIL_DPBC;
				string1   MAIL_CHK_DIGIT;
				string2   MAIL_REC_TYPE;
				STRING2   MAIL_ACE_FIPS_ST;
				string3   MAIL_COUNTY;
				string10  MAIL_GEO_LAT;
				string11  MAIL_GEO_LONG;
				string4   MAIL_MSA;
				string7   MAIL_GEO_BLK;
				string1   MAIL_GEO_MATCH;
				string5   MAIL_ERR_STAT;  			// increase length to accommodate Canadian err_stat
				STRING30	CLN_LICENSE_NBR;
				STRING1		enh_did_src:='';					//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
				//DF-28229 Add Delta build fields
				dx_common.layout_metadata;				
			END;  		

	export Srch_DBA  := record
				 final;
			   STRING254	TMP_NAME_COMPANY;
				 STRING254	TMP_NAME_DBA;
		END;

	export SlimRec := record,maxlength(8000)
	      UNSIGNED6	MARI_RID;
				STRING19 	CREATE_DTE;                  
		    STRING19	LAST_UPD_DTE;                
		    STRING19	STAMP_DTE;                   
				STRING8		DATE_FIRST_SEEN;
				STRING8		DATE_LAST_SEEN;
				STRING8 	DATE_VENDOR_FIRST_REPORTED;
				STRING8		DATE_VENDOR_LAST_REPORTED;
				unsigned6 did;
				unsigned6 bdid;
				STRING3		STD_PROF_CD;
		    STRING5		STD_SOURCE_UPD;
				string2 	type_cd;
				string5		TITLE;
				string20	FNAME;
				string20	MNAME;
				string20	LNAME;
				string5		NAME_SUFFIX;
				STRING1		ADDR_IND;
				string10	PRIM_RANGE;
				string2   PREDIR;
				string28	PRIM_NAME;
				string4   ADDR_SUFFIX;
				string2   POSTDIR;
				string10  UNIT_DESIG;
				string8		SEC_RANGE;
				string30  P_CITY_NAME;   	// increase length to accommodate Canadian City
				string25  CITY_NAME;
				string2		ST;
				string6		ZIP5;						// increase length to accommodate Canadian Zip
				string4   ZIP4;
				string254 company;
				string1		tax_type;
				string9		ssn_taxid;
				string8   party_birth;
				string10  party_phone;
				string30  license_nbr;
			  string30	off_license_nbr;
				STRING30	brkr_license_nbr;
				string2   license_state;
				unsigned8 mltreckey;
				unsigned8 cmc_slpk;
				unsigned8 pcmc_slpk;
				unsigned8	persistent_record_id;
				string30	cln_license_nbr;
				unsigned8	license_id;		 
				unsigned8	nmls_id;				
				unsigned8	foreign_nmls_id;
				STRING150 regulator;
				STRING150 federal_regulator;
				//DF-28229 Add Delta build fields
				dx_common.layout_metadata;				
		end;

// NMLS Supported File
	export Individual_Reg := record
			STRING8		DATE_FIRST_SEEN; 
			STRING8		DATE_LAST_SEEN; 
			STRING8		DATE_VENDOR_FIRST_REPORTED;
			STRING8		DATE_VENDOR_LAST_REPORTED; 
			STRING8		PROCESS_DATE; 
			STRING5		STD_SOURCE_UPD; 
			STRING1		RECORD_TYPE_IND;
			UNSIGNED8	INDIVIDUAL_NMLS_ID;
			UNSIGNED8	COMPANY_NMLS_ID;
			UNSIGNED8	INSTIT_NMLS_ID;
			STRING60	NAME_REGISTRATION;
			STRING10	REG_STATUS;
			STRING3		is_Authorized_Conduct;
			STRING150	NAME_EMPLOYER;
			STRING150	NAME_COMPANY;
			UNSIGNED8	LICENSE_ID;
			STRING50	RAW_LICENSE_TYPE;
			// STRING10	STD_LICENSE_TYPE; 
			STRING50	STD_LICENSE_DESC; 
			STRING500	REGULATOR;
			STRING10	START_DTE;
			STRING10	END_DTE;
			STRING8		CLN_START_DTE;
			STRING8		CLN_END_DTE;
	end;

	//DF-28229 Add Delta build fields
	export Individual_Reg_Base := record	
			Individual_Reg;	
			dx_common.layout_metadata;				
	end;
	
//NMLS Support File	
	export Regulatory_Action := record
		STRING8		DATE_FIRST_SEEN, 
		STRING8		DATE_LAST_SEEN, 
		STRING8		DATE_VENDOR_FIRST_REPORTED, 
		STRING8		DATE_VENDOR_LAST_REPORTED,
		STRING8		PROCESS_DATE, 
		STRING5		STD_SOURCE_UPD, 
		UNSIGNED8	STATE_ACTION_ID,
		UNSIGNED8	NMLS_ID,
		STRING2		AFFIL_TYPE_CD,                 
		STRING500	REGULATOR,
		STRING70	ACTION_TYPE,
		STRING10	ACTION_DTE,
		STRING20	MULTI_STATE_ID,
		STRING40	DOCKET_NBR,
		STRING100	URL,
		STRING8		CLN_ACTION_DTE
	end;

	//DF-28229 Add Delta build fields
	export Regulatory_Action_Base := record	
		Regulatory_Action;
		dx_common.layout_metadata;						
	end;
	
	export Disciplinary_Action	:= record
		STRING8		DATE_FIRST_SEEN,
		STRING8		DATE_LAST_SEEN, 
		STRING8		DATE_VENDOR_FIRST_REPORTED, 
		STRING8		DATE_VENDOR_LAST_REPORTED,
		STRING8		PROCESS_DATE, 
		STRING5		STD_SOURCE_UPD, 
		UNSIGNED8	INDIVIDUAL_NMLS_ID,
		STRING500	AUTHORITY_TYPE,                 
		STRING500	ACTION_TYPE,
		STRING10	ACTION_DTE,
		STRING500	AUTHORITY_NAME,
		STRING		ACTION_DETAIL,
		STRING200	URL,
		UNSIGNED8	STATE_ACTION_ID,
		STRING8		CLN_ACTION_DTE
	end;

	//DF-28229 Add Delta build fields
	export Disciplinary_Action_Base	:= record
		Disciplinary_Action;
		dx_common.layout_metadata;				
	end;

END;
