﻿IMPORT Batchshare,Doxie,Royalty;
EXPORT Layouts := MODULE

	EXPORT BatchIn := RECORD
		STRING20 acctno:='';
		STRING customer_account_number:='';
		UNSIGNED6 did:=0;
		STRING9	ssn:='';
		STRING8 dob:='';
		STRING20 name_first:='';
		STRING20 name_middle:='';
		STRING20 name_last:='';
		STRING5	 name_suffix:='';
		STRING10 prim_range:='';
		STRING2  predir:='';
		STRING28 prim_name:='';
		STRING4  addr_suffix:='';
		STRING2  postdir:='';
		STRING10 unit_desig:='';
		STRING8  sec_range:='';
		STRING25 p_city_name:='';
		STRING2  st:='';
		STRING5  zip:='';
		STRING10 phone_number:='';
		UNSIGNED4 effective_date:=0;
	END;
	
	// Phones common layout
	EXPORT PhonesCommon := RECORD
		STRING20 acctno;
		UNSIGNED seq;
		doxie.layout_pp_raw_common;
		STRING120	companyName;		
		UNSIGNED6 DotID;
		UNSIGNED6	EmpID;
		UNSIGNED6 POWID;
		UNSIGNED6 ProxID;
		UNSIGNED6 SELEID;  
		UNSIGNED6 OrgID;
		UNSIGNED6 UltID;
		STRING		subj2own_relationship;
		BatchIn - acctno batch_in;
	END;	
	
	EXPORT Phone_Relationship := RECORD
		PhonesCommon;
		UNSIGNED titleno;
		BOOLEAN isDeceased;
		BOOLEAN isFirstDegree;
	END;	

	EXPORT BatchOut := RECORD
		STRING20 acctno;
		UNSIGNED seq;
		STRING20 	AppendedDID;
		STRING20 	AppendedFirstName;
		STRING20 	AppendedMiddleName;
		STRING20 	AppendedSurname;
		STRING10 	phone;
		STRING120	AppendedCompanyName;
		STRING120	AppendedListingName;
		STRING10	AppendedStreetNumber;
		STRING2  	AppendedPreDirectional;
		STRING28 	AppendedStreetName;
		STRING4		AppendedStreetSuffix;
		STRING2		AppendedPostDirectional;
		STRING10	AppendedUnitDesignator;
		STRING10	AppendedUnitNumber;
		STRING25	AppendedCity;
		STRING2		AppendedStateCode;
		STRING5		AppendedZipCode;
		STRING4		AppendedZipCodeExtension;
		STRING10	AppendedPhoneLineType;
		STRING10	AppendedPhoneServiceType;
		STRING15	AppendedRecordType;
		UNSIGNED4	AppendedFirstDate;
		UNSIGNED4	AppendedLastDate;
		STRING		AppendedTelcoName;
		BOOLEAN		PrepaidPhoneFlag;
		STRING10	LexisNexisMatchCode;
		STRING		subj2own_relationship;
		UNSIGNED1	ownership_index;
		STRING		ownership_likelihood;
		STRING		disconnect_status;
		UNSIGNED4	ph_poss_disconnect_date;
		UNSIGNED4	ph_ported_date;
		UNSIGNED4	ph_swap_date;
		STRING10	new_phone_number_from_swap;
		STRING		reason_codes;
		STRING		contact_risk_flag;
		STRING		source; // used to preserve data source references
		STRING		source_category; 
		STRING		error_desc;
		Batchshare.Layouts.ShareErrors;		
		BatchIn - acctno;

	END;


	EXPORT Final := RECORD
		DATASET(BatchOut) Results;
		DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
	END;

END;