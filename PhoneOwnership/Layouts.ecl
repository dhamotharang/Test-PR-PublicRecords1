IMPORT Batchshare,Doxie,Phones,Royalty;
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

	EXPORT CompanyNames := RECORD
		UNSIGNED rid;
		STRING company_name;
	END;

	EXPORT Emails := RECORD
		UNSIGNED6 did;
		STRING50 clean_email;
		STRING8 date_first_seen;
		STRING8 date_last_seen;
	END;
	
	EXPORT Phone_Relationship := RECORD
		PhonesCommon;
		UNSIGNED titleno;
		BOOLEAN isDeceased;
		BOOLEAN isFirstDegree;
		STRING50 emailAddress;
	END;	

	EXPORT BatchOut := RECORD
		STRING20 	acctno;
		UNSIGNED 	seq;
		STRING20 	AppendedDID;
		STRING20 	AppendedFirstName;
		STRING20 	AppendedMiddleName;
		STRING20 	AppendedSurname;
		STRING50 	AppendedEmailAddress;
		BOOLEAN	 	validatedRecord;	//internal - to identify gateway confirmation.	
		STRING10 	phone;
		STRING120 	AppendedCompanyName;
		UNSIGNED6 	DotID;
		UNSIGNED6 	EmpID;
		UNSIGNED6 	POWID;
		UNSIGNED6 	ProxID;
		UNSIGNED6 	SELEID;  
		UNSIGNED6 	OrgID;
		UNSIGNED6 	UltID;		
		STRING120 	AppendedListingName;
		STRING10 	AppendedStreetNumber;
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
		STRING1		AppendedPhoneLineType;
		STRING1		AppendedPhoneServiceType;
		STRING15	AppendedRecordType;
		UNSIGNED4	AppendedFirstDate;
		UNSIGNED4	AppendedLastDate;
		STRING		AppendedTelcoName; //operator Name - e.g. Sprint Spectrum, NEW CINGULAR WIRELESS PCS
		STRING		AppendedCarrierName; // Carrier Name e.g. Sprint, AT&T
		BOOLEAN		PrepaidPhoneFlag;
		STRING10	LexisNexisMatchCode;
		STRING		subj2own_relationship;
		UNSIGNED	ownership_index;
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
		INTEGER 	TotalZumigoScore;
		Batchshare.Layouts.ShareErrors;		
		BatchIn - acctno;
	END;


	EXPORT Final := RECORD
		DATASET(BatchOut) Results;
		DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
		DATASET(Phones.Layouts.ZumigoIdentity.zOut) ZumigoResults;
	END;

END;