import SANCTN_Mari, standard, AID, BIPV2, dx_common;

export layouts_SANCTN_common := MODULE

export SANCTN_incident_base := RECORD
		STRING8			BATCH;
		STRING8			BATCH_DATE;
		STRING1			DBCODE;
		STRING8			INCIDENT_NUM;
		STRING8			INCIDENT_DATE;
		INTEGER			INT_KEY;
		STRING5			SRCE_CD;
		STRING8			BILLING_CODE;
		STRING20		CASE_NUM;
		STRING70		JURISDICTION;
		STRING70		AGENCY;
		STRING70		SOURCE_DOC;
		STRING17		SOURCE_REF;
		STRING70		ADDITIONAL_INFO;
		STRING8			MODIFIED_DATE;
		STRING8			ENTRY_DATE;
		STRING45		MEMBER_NAME;
		STRING45		SUBMITTER_NAME;
		STRING20		SUBMITTER_NICKNAME;
		STRING10		SUBMITTER_PHONE;
		STRING10		SUBMITTER_FAX;
		STRING80		SUBMITTER_EMAIL;
		STRING100		PROP_ADDR;
		STRING45		PROP_CITY;
		STRING2			PROP_STATE;
		STRING9			PROP_ZIP;
// AID
		AID.Common.xAID AID := 0;
//		
		UNSIGNED6		DID			:= 0; 
		UNSIGNED6		DID_SCORE := 0;
		UNSIGNED6		BDID	:= 0;
		UNSIGNED6		BDID_SCORE	:= 0;
	//CCPA-97 Per requirement, all in scope data needs to have a date when the data was collected
	STRING8 date_vendor_first_reported;
	STRING8 date_vendor_last_reported;
	//CCPA-97 Add 2 new fields for CCPA
	unsigned4 global_sid;
	unsigned8 record_sid;
	UNSIGNED4 dt_effective_first;
  	UNSIGNED4 dt_effective_last;
  	UNSIGNED1 delta_ind := 0;	
		
END;

export SANCTN_incident_did := RECORD
		SANCTN_incident_base;

//clean fields
		Standard.Name;
		string70    cname;
		Standard.L_Address.detailed;		
END;

export SANCTN_incident_bip := RECORD
		dx_common.layout_metadata;
		BIPV2.IDlayouts.l_xlink_ids;  //Added for BIP project
		unsigned8 source_rec_id := 0; //Added for BIP project		
		SANCTN_incident_did;
END;

export SANCTN_party_base := RECORD
		STRING8			BATCH;
		STRING1			DBCODE;
		STRING8			INCIDENT_NUM;
		STRING7			PARTY_NUM;
		STRING			SANCTIONS;
		STRING			ADDITIONAL_INFO;
		STRING150		PARTY_FIRM;
		STRING10		TIN;
		STRING50		NAME_FIRST;
		STRING50		NAME_LAST;
		STRING50		NAME_MIDDLE;
		STRING10		SUFFIX;
		STRING20		NICKNAME;
		STRING45		PARTY_POSITION;
		STRING150		PARTY_EMPLOYER;
		STRING9			SSN;
		STRING8			DOB;
		STRING45		ADDRESS;
		STRING45		CITY;
		STRING2 		STATE;
		STRING9			ZIP;
		STRING1			PARTY_TYPE;
		INTEGER			PARTY_KEY;
		INTEGER			INT_KEY;
		STRING20		PHONE;
		STRING500		AKANAME;
		STRING500		DBANAME;
		
// AID
		AID.Common.xAID AID	:= 0;
//
		UNSIGNED6		DID		:= 0; 
		UNSIGNED6		DID_SCORE	:= 0;
		UNSIGNED6		BDID	:= 0;
		UNSIGNED6		BDID_SCORE	:= 0;
		string1	enh_did_src := '';					//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public

	//CCPA-97 Per requirement, all in scope data needs to have a date when the data was collected
	STRING8 date_vendor_first_reported;
	STRING8 date_vendor_last_reported;
	//CCPA-97 Add 2 new fields for CCPA
	unsigned4 global_sid;
	unsigned8 record_sid;
	UNSIGNED4 dt_effective_first;
  	UNSIGNED4 dt_effective_last;
  	UNSIGNED1 delta_ind;
		
END;

export SANCTN_party_did := RECORD
		SANCTN_party_base;

//clean fields
		Standard.Name;
		string150		 ename;
		string150    cname;
		Standard.L_Address.detailed;
END;

export SANCTN_party_bip := RECORD
		BIPV2.IDlayouts.l_xlink_ids;  //Added for BIP project
		unsigned8 source_rec_id := 0; //Added for BIP project		
		SANCTN_party_did;
		
END;

export SANCTN_party_srch := RECORD
		STRING8			BATCH;
		STRING1			DBCODE;
		STRING8			INCIDENT_NUM;
		STRING7			PARTY_NUM;
		STRING			PARTY_KEY;
		UNSIGNED6		DID; 
		UNSIGNED6		DID_SCORE;
		UNSIGNED6		BDID;
		UNSIGNED6		BDID_SCORE;
		STRING45		PARTY_POSITION;
		STRING150		PARTY_EMPLOYER;
		STRING150		PARTY_FIRM;
		STRING1			PARTY_TYPE;
		STRING8			DOB;
		STRING9			SSN;
  	
	//clean name fields
		Standard.Name;
		string150		 ename;
		string150    cname;
		STRING10		 TIN;

//Clean address fields
Standard.L_Address.detailed;
	
		// STRING10		FAX_NUMBER;
		STRING			SANCTIONS;
		STRING10		PHONE;

END;

export SANCTN_incident_text	:= RECORD
		dx_common.layout_metadata;
		STRING8 BATCH;
		STRING1 DBCODE;
		STRING8 INCIDENT_NUM;
		// STRING4 NUMBER;
		STRING3 SEQ;
		STRING20 FIELD_NAME;
		STRING FIELD_TXT;
END;

export SANCTN_party_text	:= RECORD
		dx_common.layout_metadata;
		STRING8 BATCH;
		STRING1 DBCODE;
		STRING8 INCIDENT_NUM;
		STRING7 PARTY_NUM;
		STRING3 SEQ;
		STRING20 FIELD_NAME;
		STRING FIELD_TXT;
END;


export Midex_cd := RECORD
		dx_common.layout_metadata
		STRING8		BATCH;
		STRING1	 	DBCODE;
		INTEGER		PRIMARY_KEY;
		INTEGER		FOREIGN_KEY;
		STRING8		INCIDENT_NUM;
		STRING7		NUMBER;
		STRING20	FIELD_NAME;
		STRING20	CODE_TYPE;
		STRING20	CODE_VALUE;
		STRING2		CODE_STATE;
		STRING500	OTHER_DESC;
		STRING80  STD_TYPE_DESC;   	//populate only if FIELD_NAME = 'LICENSECODE'
		STRING20	CLN_LICENSE_NUMBER;
END;


export PARTY_AKA_DBA := RECORD
		dx_common.layout_metadata;
		STRING8   BATCH;
		STRING1 	DBCODE;	
		STRING8   INCIDENT_NUM;
		STRING7   PARTY_NUM;
		STRING1   NAME_TYPE;				// A=AKA, D=DBA 
		STRING50 	FIRST_NAME;
		STRING50 	MIDDLE_NAME;
		STRING50 	LAST_NAME;
		STRING100 AKA_DBA_TEXT;			// Concatenated format fo FML	for AKA names; else company
		INTEGER		PARTY_KEY;
END;


END;