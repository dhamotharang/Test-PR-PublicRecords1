IMPORT address,AID,BIPV2;
EXPORT Layouts := MODULE
	EXPORT SureScripts_In_raw := RECORD
		STRING13 	spi;
		STRING25 	dea;
		STRING25 	StateLicenseNumber;
		STRING3		SpecialtyCodePrimary;
		STRING10	PrefixName;
		STRING35	LastName;
		STRING35	FirstName;
		STRING35	MiddleName;
		STRING10	SuffixName;
		STRING35	ClinicName;
		STRING35	AddressLine1;
		STRING35	AddressLine2;
		STRING35	City;
		STRING2		State;
		STRING11	ZipCode;
		STRING25	PhonePrimary;
		STRING25	Fax;
		STRING80	Email;
		STRING25	PhoneAlt1;
		STRING3		PhoneAlt1Qualifier;
		STRING25	PhoneAlt2;
		STRING3		PhoneAlt2Qualifier;
		STRING25	PhoneAlt3;
		STRING3		PhoneAlt3Qualifier;
		STRING25	PhoneAlt4;
		STRING3		PhoneAlt4Qualifier;
		STRING25	PhoneAlt5;
		STRING3		PhoneAlt5Qualifier;
		STRING22	ActiveStartTime;
		STRING22	ActiveEndTime;	
		STRING5		ServiceLevel;
		STRING35	PartnerAccount;
		STRING22	LastModifiedDate;
		STRING1		RecordChange;							//N = New, U=Updated, D=Deactivated
		STRING5		OldServiceLevel;
		STRING100	TextServiceLevel;
		STRING100	TextServiceLevelChange;
		STRING5		Version;
		STRING10	NPI;
		STRING13	NPILocation;
		STRING35	SpecialityType1;
		STRING35	SpecialityType2;
		STRING35	SpecialityType3;
		STRING35	SpecialityType4;
		STRING35	FileID;
		STRING35	MedicareNumber;
		STRING35	MedicaidNumber;
		STRING35	DentistLicenseNumber;
		STRING35	UPIN;
		STRING35	PPONumber;
		STRING35	SocialSecurity;
		STRING35	PriorAuthorization;
		STRING35	MutuallyDefined;
		STRING7		InStoreNCPDPID;
		string2		CRLF;
	END; // Record SureScripts_In_raw

	EXPORT SureScripts_In := RECORD
		STRING13 	spi;
		STRING25 	dea;
		STRING25 	StateLicenseNumber;
		STRING3		SpecialtyCodePrimary;
		STRING10	PrefixName;
		STRING35	LastName;
		STRING35	FirstName;
		STRING35	MiddleName;
		STRING10	SuffixName;
		STRING35	ClinicName;
		STRING35	AddressLine1;
		STRING35	AddressLine2;
		STRING35	City;
		STRING2		State;
		STRING11	ZipCode;
		STRING25	PhonePrimary;
		STRING25	Fax;
		STRING80	Email;
		STRING25	PhoneAlt1;
		STRING3		PhoneAlt1Qualifier;
		STRING25	PhoneAlt2;
		STRING3		PhoneAlt2Qualifier;
		STRING25	PhoneAlt3;
		STRING3		PhoneAlt3Qualifier;
		STRING25	PhoneAlt4;
		STRING3		PhoneAlt4Qualifier;
		STRING25	PhoneAlt5;
		STRING3		PhoneAlt5Qualifier;
		STRING22	ActiveStartTime;
		STRING22	ActiveEndTime;	
		STRING5		ServiceLevel;
		STRING35	PartnerAccount;
		STRING22	LastModifiedDate;
		STRING1		RecordChange;							//N = New, U=Updated, D=Deactivated
		STRING5		OldServiceLevel;
		STRING100	TextServiceLevel;
		STRING100	TextServiceLevelChange;
		STRING5		Version;
		STRING10	NPI;
		STRING13	NPILocation;
		STRING35	SpecialityType1;
		STRING35	SpecialityType2;
		STRING35	SpecialityType3;
		STRING35	SpecialityType4;
		STRING35	FileID;
		STRING35	MedicareNumber;
		STRING35	MedicaidNumber;
		STRING35	DentistLicenseNumber;
		STRING35	UPIN;
		STRING35	PPONumber;
		STRING35	SocialSecurity;
		STRING35	PriorAuthorization;
		STRING35	MutuallyDefined;
		STRING7		InStoreNCPDPID;
	END; // Record SureScripts_In
	
	EXPORT src_and_date	:= RECORD
		UNSIGNED6 	pid;
		STRING12 		src;		
		UNSIGNED4 	dt_vendor_first_reported;
		UNSIGNED4 	dt_vendor_last_reported;
		UNSIGNED4		dt_first_seen	:= 0;
		UNSIGNED4		dt_last_seen	:= 0;
		STRING1   	record_type;
		UNSIGNED8	 	source_rid;
		UNSIGNED8	 	lnpid;
	END;
	
		EXPORT clean_name	:= RECORD
			address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			STRING35	clean_company_name;
			STRING1 name_type:='';
			UNSIGNED8	nid;
		END;
	
	EXPORT Base := RECORD	
		
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		//Original fields		
		SureScripts_In;
		STRING10	Spec_Code;				// Specialty Code derived from SpecialtyCodePrimary in the input file
		STRING50	Spec_Desc;				// Specialty Code description
		STRING10	Activity_Code;
		STRING5		Practice_Type_Code;
		STRING50	Practice_Type_Desc;
		STRING10	Taxonomy;
		
		//src_and_date -[pid,src,ln_record_type,source_rid];
		src_and_date -[pid];
		clean_name -[clean_company_name];
		STRING100	clean_Clinic_name;
		STRING70 Prepped_Addr1;				// Address line1 & Line2 cat'ed
		STRING115 Prepped_Addr2;			// Address line1, 2, City, State, Zip5 cat'ed
		
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
		string10 	clean_Phone;
		BIPV2.IDlayouts.l_xlink_ids;
	END;// Record Base	
	
	EXPORT Base_Less_Orig := RECORD
	
		SureScripts_In.spi;
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		src_and_date -[pid];
		clean_name -[clean_company_name];
		STRING100	clean_Clinic_name;
		STRING70 Prepped_Addr1;				// Address line1 & Line2 cat'ed
		STRING115 Prepped_Addr2;			// Address line1, 2, City, State, Zip5 cat'ed
		
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
		string10 	clean_Phone;
		BIPV2.IDlayouts.l_xlink_ids;
	END;// Base_Less_Orig
	
	EXPORT Spec_Codes := RECORD		// Speicality Codes 
		STRING5		In_Code;
		STRING10	Out_Code;
	END; //Speicality Codes 
	
	EXPORT SpecDetails := RECORD		// Speicality Code Details
		STRING10	Spec_Code;
		STRING50	Spec_Desc;
		STRING10	Activity_Code;
		STRING5		Practice_Type_Code;
		STRING50	Practice_Type_Desc;
	END; //SpecDetails

	EXPORT Base_Spec_Codes := RECORD
		STRING5		In_Code;
		STRING10	Out_Code;
		STRING1   record_type;			
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
	END;
	
	EXPORT Base_SpecialtyCodes := RECORD		// Speicality Codes
		STRING5		In_Code;
		STRING10	Spec_Code;
		STRING50	Spec_Desc;
		STRING10	Activity_Code;
		STRING5		Practice_Type_Code;
		STRING50	Practice_Type_Desc;
		STRING1   record_type;		
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;		
	END; // Spec_Codes_Base 
	
	EXPORT Prof_lic_Taxonomy_Input := RECORD		// Professions Licenses - Taxonomy Mapping Input/raw file
		STRING10	Taxonomy;
		STRING	Raw_License_Type;
	END;	
	
	EXPORT Prof_lic_Taxonomy_Mapping := RECORD		// Professions Licenses - Taxonomy Mapping
		STRING10	Taxonomy;
		STRING100	Raw_License_Type;
		UNSIGNED4 Date_Imported;
	END;
	
	EXPORT HMS_Spec_to_Taxonomy_Input := RECORD		// HMS_Spec_to_ - Taxonomy Mapping Input/raw file
		STRING10	Spec_Code;
		STRING10	Taxonomy;
	END;	
	
	EXPORT HMS_Spec_to_Taxonomy := RECORD		// HMS_Spec_to_ - Taxonomy Mapping
		STRING10	Spec_Code;
		STRING10	Taxonomy;
		UNSIGNED4 Date_Imported;
	END;		
		
END; // Module