import prte2_sanctn_np, prte_csv, bipv2, sanctn_mari, standard,aid;

EXPORT Layouts := module
//Raw Layouts		
	export recIncident := record
		STRING8 	BATCH;
		STRING10 	BATCH_DATE;					// Date loaded to MIDEX. fmt MM/DD/YYYY
		STRING1 	DBCODE;							// N=Non-public, F=FreddieMac
		STRING8 	INCIDENT_NUM;				// Use to link to PARTYDATA
		STRING10 	INCIDENT_DATE;							// fmt MM/DD/YY does not contain leading zeroes for month or day
		INTEGER		INT_KEY;	
		STRING5		srce_cd;	
		STRING8 	BILLING_CODE;				// Feddie Mac only field
		STRING20 	CASE_NUM;						// Feddie Mac only field
		STRING70 	JURISDICTION;				// Feddie Mac only field
		STRING70 	AGENCY;							// Feddie Mac only field
		STRING70 	SOURCE_DOC;					// Feddie Mac only field
		STRING17 	SOURCE_REF;					// Non-Public only field		
		STRING70 	ADDITIONAL_INFO;		// Text field: Feddie Mac only field
		STRING10 	MODIFIED_DATE;				// Last Modified Date, fmt MM/DD/YYYY
		STRING10 	ENTRY_DATE;					// Date the incident was entered: Non-Public only field		
		STRING45	MEMBER_NAME;				// Name of submitting institution; Non-Public only field
		STRING45	SUBMITTER_NAME;			// Name of submitter; Non-Public only field	
		STRING20	SUBMITTER_NICKNAME;
		STRING10	SUBMITTER_PHONE;		// Non-Public only field	
		STRING10	SUBMITTER_FAX;			// Non-Public only field
		STRING80	SUBMITTER_EMAIL;		// Non-Public only field	
		STRING100	PROP_ADDR;					// Address of the property the incident is referencing; Non-Public only field
		STRING45	PROP_CITY;					// Non-Public only field
		STRING2		PROP_STATE;					// Non-Public only field
		STRING9		PROP_ZIP;						// Non-Public only field	
		AID.Common.xAID AID 		:= 0;
		UNSIGNED6		DID					:= 0; 
		UNSIGNED6		DID_SCORE 	:= 0;
		UNSIGNED6		BDID				:= 0;
		UNSIGNED6		BDID_SCORE	:= 0;
		BIPV2.IDlayouts.l_xlink_ids;  //Added for BIP project
		unsigned8 source_rec_id := 0; //Added for BIP project		
		Standard.Name;
		string70    cname;
		Standard.L_Address.detailed;	
		UNSIGNED8 __internal_fpos__;
		STRING8		LINK_DOB;
		STRING9		LINK_SSN;
		STRING9		LINK_FEIN;
		STRING8		LINK_INC_DATE;
		STRING10	CUST_NAME;
		STRING10  BUG_NUM;
end;


export recParty := record
		STRING8 	BATCH;
		STRING1 	DBCODE;
		STRING8 	INCIDENT_NUM;
		STRING7 	PARTY_NUM;								// Originator designated by NUMBER=0
		STRING 		SANCTIONS;								// Feddie Mac Only
		STRING 		ADDITIONAL_INFO;					// Text field: Feddie Mac only
		STRING150 PARTY_FIRM;
		STRING10 	TIN;
		STRING50 	NAME_FIRST;
		STRING50 	NAME_LAST;
		STRING50 	NAME_MIDDLE;
		STRING10 	SUFFIX;
		string20	NICKNAME;
		STRING45 	PARTY_POSITION;
		STRING150 PARTY_EMPLOYER;
		STRING11 	SSN;
		STRING10 	DOB;
		STRING45 	ADDRESS;
		STRING30 	CITY;
		STRING2 	STATE;
		STRING10 	ZIP;
		STRING		PARTY_TYPE;
		INTEGER 	PARTY_KEY;					 					// Link to PROFESSIONCODE,LICENSECODE
		INTEGER 	INT_KEY;	
		STRING20	PHONE;								// new field
		STRING500 AKANAME;							// new field
		STRING500	DBANAME;							// new field
		unsigned8	AID;
		unsigned6	did;
		unsigned3 did_score;
		unsigned6 bdid;
		unsigned3 bdid_score;
		STRING1		enh_did_src:='';			//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
		bipv2.IDlayouts.l_xlink_ids;		//Added for BIP project
		unsigned8 source_rec_id := 0;
	//clean fields
		Standard.Name;
		string150		 ename;
		string150    cname;
		Standard.L_Address.detailed;
		UNSIGNED8 __internal_fpos__;
		STRING8		LINK_DOB;
		STRING9		LINK_SSN; 
		STRING9		LINK_FEIN;
		STRING8		LINK_INC_DATE;
		STRING10	CUST_NAME;
		STRING10  BUG_NUM;
		STRING10	REQ;
end;


export recCode := record
		SANCTN_MARI.layouts_SANCTN_common.Midex_cd; 
		UNSIGNED8 __internal_fpos__;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
/*		
		STRING8 	BATCH;
		STRING1 	DBCODE;
		INTEGER 	PRIMARY_KEY;										
		INTEGER 	FOREIGN_KEY;								// Party PK or IntPK link to INTERNALCODE; also can use INCIDENT_NUMER + NUMBER
		INTEGER 	INCIDENT_NO;				// Link to INCIDENTDATA
		STRING7 	NUMBER;
		STRING20 	FIELDNAME;					// LICENSECODE, INTERNALCODE, PROFESSIONCODE
		STRING20 	CODETYPE;						// LICENSECODE(license type), INTERNALCODE(verification or incident; do not display), PROFESSIONCODE(blank)
		STRING20 	CODEVALUE;					// LICENSECODE(license_number), INTERNALCODE('verfication','incident'),PROFESSIONCODE(profession ocde) 
		STRING10 	CODESTATE;					// LICENSECODE(license state)
		STRING500 OTHERDESC;					// PROFESSIONCODE(addl information for CODEVALUE), INTERNALCODE(addl info for Verification/Incident code)
		STRING		STD_TYPE_DESC;
		STRING		CLN_LICENSE_NUMBER;
*/		
		
end;

export recIncidentText := record
		SANCTN_MARI.layouts_SANCTN_common.SANCTN_incident_text;
		UNSIGNED8 __internal_fpos__;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
/*		
		STRING8 	BATCH;
		STRING1 	DBCODE;
		INTEGER 	INCIDENT_NO;			// Link to INCIDENTDATA
		STRING3  	SEQ;							// Order to display the text of this FIELDNAME
		STRING20 	FIELDNAME;				// INCIDENT_TEXT, OTHERINFO, INCIDENT_RESPONSE
		STRING 		TXT;							//There will be a tilde(~) at the end of the paragrapj if there was a CR in the text
*/	
end;

export recPartyText := record
		SANCTN_MARI.layouts_SANCTN_common.SANCTN_party_text;
		UNSIGNED8 __internal_fpos__;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
		
end;


export recPartyAkaDba := record
		SANCTN_MARI.layouts_SANCTN_common.PARTY_AKA_DBA;
		UNSIGNED8 __internal_fpos__;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
end;



//Base Layouts
	export incident_base := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip;
		STRING10	CUST_NAME;
		STRING10  BUG_NUM;
		STRING8		LINK_DOB;
		STRING9		LINK_SSN;
		STRING9		LINK_FEIN;
		STRING8		LINK_INC_DATE;
	end;
	
	export incidentcode_base := record
		SANCTN_Mari.layouts_SANCTN_common.Midex_cd;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
	end;	
		
	export incidenttext_base := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_text;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
		end;	
		
	export party_base := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip;
		STRING8		LINK_DOB;
		STRING9		LINK_SSN;
		STRING9		LINK_FEIN;
		STRING8		LINK_INC_DATE;
		STRING10	CUST_NAME;
		STRING10  BUG_NUM;
		STRING10	REQ;
	end;	
		
	export partytext_base := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
	end;
	
	export party_aka_dba_base := record
		SANCTN_Mari.layouts_SANCTN_common.party_aka_dba;
		STRING10 	CUST_NAME;
		STRING10	BUG_NUM;
	end;
		


// Key Layouts
// BDID KEY
	export bdid_key		:= record
		UNSIGNED6  	BDID;
		STRING8 		BATCH;
		INTEGER 		INCIDENT_NUM;
		STRING7 		PARTY_NUM;		
	end;

// DID KEY																																			
	export did_key := record
		UNSIGNED6  DID;	
		STRING8 		BATCH;
		INTEGER 		INCIDENT_NUM;
		STRING7 		PARTY_NUM;		
	end;

	export incident_key			:= sanctn_mari.layouts_SANCTN_common.SANCTN_incident_base;
	
	export layout_Midex_cd	:= sanctn_mari.layouts_SANCTN_common.Midex_cd;
	
	export IncidentText_Key := record, MAXLENGTH(9000)
		sanctn_mari.layouts_SANCTN_common.SANCTN_incident_text;
	end;
		

// License NBR Key
	export License_Key := record
		STRING8  BATCH;
		INTEGER  iNCIDENT_NUM;
		STRING7  PARTY_NUM;
		string20 LICENSE_NBR;
		STRING2  LICENSE_STATE;
		STRING80 LICENSE_TYPE;
		string20 CLN_LICENSE_NUMBER;
end;


// License MIDEX Key
	export License_Midex_Key := record
		STRING8		BATCH;
		STRING1	 	DBCODE;
		STRING8		INCIDENT_NUM;
		STRING7		PARTY_NUM;
		STRING20	FIELD_NAME;
		STRING20	LICENSE_TYPE;
		STRING20	CODE_VALUE;
		STRING2		LICENSE_STATE;
		STRING500	OTHER_DESC;
		STRING80  STD_TYPE_DESC;   	
		STRING20	CLN_LICENSE_NUMBER;
		STRING26 	MIDEX_RPT_NBR;
end;

	
// NMLS ID Key
	export NMLS_ID_key := record
		STRING8  BATCH;
		INTEGER  iNCIDENT_NUM;
		STRING7 	PARTY_NUM;
		STRING2  	LICENSE_STATE;
		STRING80 	LICENSE_TYPE;
		STRING20 	NMLS_ID;
		STRING26 	MIDEX_RPT_NBR;
	end;


// NMLS MIDEX Key
	export NMLS_MIDEX_Key := record
		STRING8		BATCH;
		STRING1	 	DBCODE;
		STRING8		INCIDENT_NUM;
		STRING7		PARTY_NUM;
		STRING20	FIELD_NAME;
		STRING20	LICENSE_TYPE;
		STRING20	CODE_VALUE;
		STRING2		LICENSE_STATE;
		STRING500	OTHER_DESC;
		STRING80  STD_TYPE_DESC;   	
		STRING20	NMLS_ID;
		STRING26 	MIDEX_RPT_NBR;
end;	

//Party Key
	export Party_Key := record
			SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base - enh_did_src;
	end;		


// PaRTY AKE Key
	export PARTY_AKA_DBA_Key := record
  SANCTN_Mari.layouts_SANCTN_common.party_aka_dba AND NOT [FIRST_NAME,MIDDLE_NAME,LAST_NAME,PARTY_KEY];
	end;

	
// Party Midex Key	
	export Party_Midex_Key := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_srch;
		string26 midex_rpt_nbr;
		BIPV2.IDlayouts.l_xlink_ids;
	end;


// Party Text Key
	export rKeySanctn__key__sanctn__np__partytext	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__partytext;
	END;


// SSN4 Key
	export SSN4_key := record
		STRING4 ssn4;
		STRING8 batch;
		STRING8 incident_num;
		STRING7 party_num;
	end;

// TIN Key	
	export TIN_Key := record
		STRING10 TIN;
		STRING8 BATCH;
		STRING8 INCIDENT_NUM;
		STRING7 PARTY_NUM;
	end;


// Creating Search File needed for creating AUTOKEYS
export autokeys := record
    unsigned6 did;
		unsigned6 bdid;
		unsigned6 aid;
		unsigned4 lookups;
		STRING10 	BATCH;
		STRING8 	INCIDENT_NUM;
		STRING7		PARTY_NUM;
		STRING50	NAME_FIRST;
		STRING50	NAME_LAST;
		STRING50	NAME_MIDDLE;
		STRING10	SUFFIX;
		STRING150	PARTY_FIRM;
		STRING45	ADDRESS;
		STRING45	CITY;
		STRING2		STATE;
		STRING9		ZIP;
		standard.addr addr;
		standard.name name;
    string100 company;
		string8   DOB;
		string10  PHONE;
		string9   SSN_TIN;
		string11	SSN;
		string10	TIN;
		string5   SRCE_CD;
		STRING1		DBCODE;
		unsigned1 zero := 0;
		string1   blank:='';
end;

	export autokeys2 := record
		SANCTN_Mari.layouts_SANCTN_common.party_aka_dba;
		string5		title;
		string20 	fname;
		string20 	mname;
		string20 	lname;
		string5  	name_suffix;
		string3  	name_score;
		string100 cname;
end;
	
end;