IMPORT address,AID,BIPV2;
EXPORT Layouts := MODULE
	EXPORT Medicaid_VT := RECORD
		STRING10 	Provider_ID;
		STRING10	NPI;
		STRING12	Taxonomy;
		STRING100	Provider_Name;
		STRING100	Provider_Address;
		STRING25	Phone;
	END; // Record Medicaid_In_raw
	
	EXPORT Medicaid_IL := RECORD
		STRING100	Name;
		STRING100	Address;
		STRING50	CityState;
		STRING5		ZipCode;
		STRING15	Phone;
		STRING25	ProviderTypeDesc;
		STRING15	MedicaidId;
		STRING10	NPI;
	END; // Record Medicaid_In_raw	
	
	EXPORT Medicaid_NE := RECORD
		STRING100	Provider_Name;		// There are two columns with Provider Name. Per Jay, second one, here called Name is more recent
		STRING15	License_Number;
		STRING10	NPI;
		STRING100	ProviderType;
		STRING100	Name;							// There are two columns with Provider Name. Per Jay, second one, here called Name is more recent		
		STRING100 Speciality;
		STRING1		Status;
		STRING100	Address1;
		STRING100	Address2;
		STRING100	Address3;
		STRING50	OfficeCity;
		STRING2		OfficeState;
		STRING5		OfficeZipCode;
	END; // Record Medicaid_In_raw	

	EXPORT Medicaid_NY := RECORD
		STRING10	Prov_ID;		// There are two columns with Provider Name. Per Jay, second one, here called Name is more recent
		STRING100	Prov_Name;
		STRING10	NPI;
		STRING3		Prov_Type_CD;
		STRING100	Prov_Type_Name;
		STRING100	Prov_Addr_Str;
		STRING100	Prov_Addr_Line_2;
		STRING50	Prov_Addr_City;
		STRING2		Prov_Addr_St;
		STRING5		Postal_CD;
		STRING10	Prov_Tele_Num;
		STRING4		Spec_CD;
		STRING100	Prov_Spec_Desc;
		STRING1		Active_Ind
	END; // Record Medicaid_In_raw	
	
	
	
	
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
	
	EXPORT Base_VT := RECORD			
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		//Original fields	
		String2 Data_State;
		Medicaid_VT;
		unsigned1  entity_type_code;
		String25 FirstName;
		String35 LastName;
		String55 CompanyName;
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
	
	EXPORT Base_IL := RECORD			
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		//Original fields	
		String2 Data_State;
		Medicaid_IL;
		unsigned1  entity_type_code;
		String55 CompanyName;		
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
	END;// Record Base_IL

	EXPORT Base_NE := RECORD			
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		//Original fields	
		String2 Data_State;
		Medicaid_NE;
		unsigned1  entity_type_code;
		String55 CompanyName;	
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
	END;// Record Base_NE	
	
	EXPORT Base_NY := RECORD			
		UNSIGNED6 did 				:= 0;//Lex Id
		UNSIGNED1 did_score 	:= 0;	// macro returns this cofidence score
		UNSIGNED6 bdid;
		unsigned1 bdid_score := 0;
		unsigned4 best_dob;					// Needed just so a macro can run to get Bdid
		string9   best_ssn;					// Needed just so a macro can run to get Bdid
		
		//Original fields	
		String2 Data_State;
		Medicaid_NY;
		unsigned1  entity_type_code;
		String25 FirstName;
		String35 LastName;
		String55 CompanyName;
		//src_and_date -[pid,src,ln_record_type,source_rid];
		src_and_date -[pid];
		clean_name -[clean_company_name];
		STRING100	clean_Clinic_name;
		STRING70 Prepped_Addr1;				// Address line1 & Line2 cat'ed
		STRING115 Prepped_Addr2;			// Address line1, 2, City, State, Zip5 cat'ed
//		STRING12	Taxonomy;
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
	
END; // Module