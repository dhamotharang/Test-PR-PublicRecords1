import PAW,doxie, BIPV2;
export Layouts := module
	export search := record
		unsigned6 contact_id;
		boolean isDeepDive := false;
	end;
	export rptPhone := record
		boolean verified;
		STRING10 phone10;
		STRING4  timezone;
	end;
	export raw := record
		recordof(PAW.Key_contactID);
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		string4   timezone;
		boolean hasCriminalConviction := false;
		boolean isSexualOffender := false;		
	end;
	export rptSsn := record
		string9 ssn;
	end;
	export rptIndvName := record
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
	end;
	export rptAddr := record
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string5 unit_desig;
		string8 sec_range;
		string25 city;
		string2 state;
		string5 zip;
		string4 zip4;
		dataset(rptPhone) phones {maxcount(Constants.MAX_PHONES_PER_ADDR)};
	end;
	export rptFein := record
		string9 fein;
	end;
	export rptBizName := record
		string120 company_name;
	end;
	export rptDtSeen := record
		string8 dt_first_seen;
		string8 dt_last_seen;
	end;
	export rptPosition := record
		dataset(rptDtSeen) dates {maxcount(Constants.MAX_DATES_PER_POSITION)};
		string35 company_title;
		string35 company_department;
	end;
	export rptEmployer := record
		unsigned6 bdid;
		BIPV2.IDlayouts.l_header_ids;
		dataset(rptDtSeen) dates {maxcount(Constants.MAX_DATES_PER_EMPLOYER)};
		dataset(rptFein) feins {maxcount(Constants.MAX_FEINS_PER_EMPLOYER)};
		dataset(rptBizName) company_names {maxcount(Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)};
		dataset(rptAddr) addrs {maxcount(Constants.MAX_ADDRS_PER_EMPLOYER)};
		dataset(rptPosition) positions {maxcount(Constants.MAX_POSITIONS_PER_EMPLOYER)};
	end;
	export rptPerson := record
		boolean isDeepDive;
		unsigned2 penalt;
		unsigned6 did;
		dataset(rptSsn) ssns {maxcount(Constants.MAX_SSNS_PER_PERSON)};
		dataset(rptIndvName) names {maxcount(Constants.MAX_NAMES_PER_PERSON)};
		dataset(rptEmployer) employers {maxcount(Constants.MAX_EMPLOYERS_PER_PERSON)};
		boolean hasCriminalConviction := false;
		boolean isSexualOffender := false;		
	end;
	
	EXPORT batch_in := RECORD
		UNSIGNED2 penalt := 0;
		string8 matchcodes;
		integer error_code;
	  doxie.layout_inBatchMaster.acctno;
		recordof(paw.Key_contactID);
	END;
		
	EXPORT layout_for_PAW_penalties := RECORD

		STRING20	 	_acctno      := '';
		
		STRING20		_name_first  := '';
		STRING20		_name_middle := '';
		STRING20		_name_last   := '';
		STRING5			_name_suffix := '';
		
		STRING120   _comp_name   := '';

		STRING10  	_prim_range  := '';
		STRING2   	_predir      := '';
		STRING28  	_prim_name   := '';
		STRING4   	_addr_suffix := '';
		STRING2   	_postdir     := '';
		STRING10  	_unit_desig  := '';
		STRING8   	_sec_range   := '';
		STRING25  	_p_city_name := '';
		STRING2   	_st          := '';
		STRING5   	_z5          := '';
		STRING4   	_zip4        := '';

		STRING12		_ssn         := '';
		STRING12		_fein        := '';
		STRING8			_dob         := '';
		STRING10  	_homephone   := '';
		STRING16		_workphone   := '';

	END;
	
	EXPORT Batch_out := RECORD
	    string20  acctno;
			unsigned2 penalt := 1000;
			integer   error_code;
			string8   matchcodes;
			
			string12  pawk_1_did;
			string3   pawk_1_confidence_level ;			
			string20  pawk_1_first ;
			string20  pawk_1_middle ;
			string20  pawk_1_last ;
			string5   pawk_1_suffix ;
			string9   pawk_1_ssn ;
			string35  pawk_1_title ;
			string8   pawk_1_first_seen ;
			string8   pawk_1_last_seen ;			
			string12  pawk_1_bdid;			
			string35  pawk_1_company_name ;
			string35  pawk_1_department ;
			string9   pawk_1_fein ;
			string80  pawk_1_address ;
			string25  pawk_1_city ;
			string2   pawk_1_state ;
			string5   pawk_1_zip5 ;
			string4   pawk_1_zip4 ;
			string10  pawk_1_phone10 ;
			string5   pawk_1_verified ;
			string60  pawk_1_email ;

			string12  pawk_2_did;
			string3   pawk_2_confidence_level ;			
			string20  pawk_2_first ;
			string20  pawk_2_middle ;
			string20  pawk_2_last ;
			string5   pawk_2_suffix ;
			string9   pawk_2_ssn ;
			string35  pawk_2_title ;
			string8   pawk_2_first_seen ;
			string8   pawk_2_last_seen ;			
			string12  pawk_2_bdid;			
			string120 pawk_2_company_name ;
			string35  pawk_2_department ;
			string9   pawk_2_fein ;
			string80  pawk_2_address ;
			string25  pawk_2_city ;
			string2   pawk_2_state ;
			string5   pawk_2_zip5 ;
			string4   pawk_2_zip4 ;
			string10  pawk_2_phone10 ;
			string5   pawk_2_verified ;
			string60  pawk_2_email ;
			
			string12  pawk_3_did;
			string3   pawk_3_confidence_level ;			
			string20  pawk_3_first ;
			string20  pawk_3_middle ;
			string20  pawk_3_last ;
			string5   pawk_3_suffix ;
			string9   pawk_3_ssn ;
			string35  pawk_3_title ;
			string8   pawk_3_first_seen ;
			string8   pawk_3_last_seen ;			
			string12  pawk_3_bdid;			
			string120 pawk_3_company_name ;
			string35  pawk_3_department ;
			string9   pawk_3_fein ;
			string80  pawk_3_address ;
			string25  pawk_3_city ;
			string2   pawk_3_state ;
			string5   pawk_3_zip5 ;
			string4   pawk_3_zip4 ;
			string10  pawk_3_phone10 ;
			string5   pawk_3_verified ;
			string60  pawk_3_email ;
			
			string12  pawk_4_did;
			string3   pawk_4_confidence_level ;			
			string20  pawk_4_first ;
			string20  pawk_4_middle ;
			string20  pawk_4_last ;
			string5   pawk_4_suffix ;
			string9   pawk_4_ssn ;
			string35  pawk_4_title ;
			string8   pawk_4_first_seen ;
			string8   pawk_4_last_seen ;			
			string12  pawk_4_bdid;			
			string120 pawk_4_company_name ;
			string35  pawk_4_department ;
			string9   pawk_4_fein ;
			string80  pawk_4_address ;
			string25  pawk_4_city ;
			string2   pawk_4_state ;
			string5   pawk_4_zip5 ;
			string4   pawk_4_zip4 ;
			string10  pawk_4_phone10 ;
			string5   pawk_4_verified ;
			string60  pawk_4_email ;
			
			string12  pawk_5_did;
			string3   pawk_5_confidence_level ;			
			string20  pawk_5_first ;
			string20  pawk_5_middle ;
			string20  pawk_5_last ;
			string5   pawk_5_suffix ;
			string9   pawk_5_ssn ;
			string35  pawk_5_title ;
			string8   pawk_5_first_seen ;
			string8   pawk_5_last_seen ;			
			string12  pawk_5_bdid;			
			string120 pawk_5_company_name ;
			string35  pawk_5_department ;
			string9   pawk_5_fein ;
			string80  pawk_5_address ;
			string25  pawk_5_city ;
			string2   pawk_5_state ;
			string5   pawk_5_zip5 ;
			string4   pawk_5_zip4 ;
			string10  pawk_5_phone10 ;
			string5   pawk_5_verified ;
			string60  pawk_5_email ;
			
	ENd;
end;
