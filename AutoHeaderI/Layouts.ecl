import ut, AutoHeaderI;

export Layouts := module

	export Fetch_Batch_Input_Layout := record
		// Unique account number
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		
		// ID numbers
		AutoHeaderI.Types.did                    did;
		AutoHeaderI.Types.bdid                   bdid;

		// Tax IDs
		AutoHeaderI.Types.ssn                    ssn;
		AutoHeaderI.Types.ssntypos               ssntypos;
		AutoHeaderI.Types.fein                   fein;

		// Person Name
		AutoHeaderI.Types.unparsedfullname       unparsedfullname;
		AutoHeaderI.Types.lfmname                lfmname;
		AutoHeaderI.Types.lastname               lastname;
		AutoHeaderI.Types.lname                  lname;
		AutoHeaderI.Types.phoneticmatch          phoneticmatch;
		AutoHeaderI.Types.firstname              firstname;
		AutoHeaderI.Types.allownicknames         allownicknames;
		AutoHeaderI.Types.middlename             middlename;

		// Business Name
		AutoHeaderI.Types.companyname            companyname;
		AutoHeaderI.Types.cn                     cn;
		AutoHeaderI.Types.company_t              company;
		AutoHeaderI.Types.corpname               corpname;
		AutoHeaderI.Types.asisname               asisname;
		AutoHeaderI.Types.nameasis               nameasis;

		// Addresses
		AutoHeaderI.Types.addr                   addr;
		AutoHeaderI.Types.prim_range             prim_range;
		AutoHeaderI.Types.primrange              primrange;
		AutoHeaderI.Types.prim_name              prim_name;
		AutoHeaderI.Types.primname               primname;
		AutoHeaderI.Types.street_name            street_name;
		AutoHeaderI.Types.sec_range              sec_range;
		AutoHeaderI.Types.secrange               secrange;
		AutoHeaderI.Types.fuzzysecrange          fuzzysecrange;
		AutoHeaderI.Types.statecityzip           statecityzip;
		AutoHeaderI.Types.city                   city;
		AutoHeaderI.Types.st                     st;
		AutoHeaderI.Types.st_orig                st_orig;
		AutoHeaderI.Types.state                  state;
		AutoHeaderI.Types.zip                    zip;
		AutoHeaderI.Types.z5                     z5;
		AutoHeaderI.Types.zipradius              zipradius;
		AutoHeaderI.Types.county                 county;

		// Phone
		AutoHeaderI.Types.phone                  phone;

		// DOBs
		AutoHeaderI.Types.dob                    dob;
		AutoHeaderI.Types.agehigh                agehigh;
		AutoHeaderI.Types.agelow                 agelow;
		
		// Other settings
		AutoHeaderI.Types.excludelessors         excludelessors;
		AutoHeaderI.Types.isFCRAval              isFCRAval;
		AutoHeaderI.Types.isPRP                  isPRP;
		AutoHeaderI.Types.lookuptype             lookuptype;
		AutoHeaderI.Types.moxievehicles          moxievehicles;
		AutoHeaderI.Types.othercity1             othercity1;
		AutoHeaderI.Types.otherlastname1         otherlastname1;
		AutoHeaderI.Types.otherstate1            otherstate1;
		AutoHeaderI.Types.otherstate2            otherstate2;
		AutoHeaderI.Types.partytype              partytype;
		AutoHeaderI.Types.relativefirstname1     relativefirstname1;
		AutoHeaderI.Types.relativefirstname2     relativefirstname2;
		AutoHeaderI.Types.setrepaddr             setrepaddr;
		AutoHeaderI.Types.setrepaddrbit          setrepaddrbit;
		AutoHeaderI.Types.simplifiedcontactreturn simplifiedcontactreturn;
	end;

	export Fetch_Batch_Indv_Address_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.lookup_value2          lookup_value2;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.sec_range_value        sec_range_value;
		AutoHeaderI.Types.FuzzySecRange_value    FuzzySecRange_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.city_codes_set         city_codes_set;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_val                zip_val;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
	end;

	export Fetch_Batch_Indv_Name_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value_20     lname_set_value_20;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;
	
	export Fetch_Batch_Indv_Phone_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.lname_value            lname_value;
	end;
	
	export Fetch_Batch_Indv_SSN_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.fuzzy_ssn              fuzzy_ssn;
	end;
	
	export Fetch_Batch_Indv_StCityName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;
	
	export Fetch_Batch_Indv_StName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;
	
	export Fetch_Batch_Indv_Zip_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value_20     lname_set_value_20;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;
	
	export Fetch_Batch_Indv_ZipPRLname_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.lname_value            lname_value;
	end;
	
	export Fetch_Batch_Indv_Layout := record
		Fetch_Batch_Indv_Zip_Layout or
		Fetch_Batch_Indv_StName_Layout or
		Fetch_Batch_Indv_StCityName_Layout or
		Fetch_Batch_Indv_Phone_Layout or
		Fetch_Batch_Indv_ZipPRLname_Layout or
		Fetch_Batch_Indv_Name_Layout or
		Fetch_Batch_Indv_SSN_Layout or
		Fetch_Batch_Indv_Address_Layout;
	end;
	
	export Fetch_Hdr_Batch_Indv_DID_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.did_value              did_value;
	end;

	export Fetch_Hdr_Batch_Indv_RID_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.rid_value              rid_value;
	end;

	export Fetch_Hdr_Batch_Indv_SSN_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.fuzzy_ssn              fuzzy_ssn;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.score_threshold_value  score_threshold_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.SearchGoodSSNOnly_value SearchGoodSSNOnly_value;
	end;

	export Fetch_Hdr_Batch_Indv_StNameSmall_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.score_threshold_value  score_threshold_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_Phone_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.lname_value            lname_value;
	end;

	export Fetch_Hdr_Batch_Indv_Street_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.BpsLeadingNameMatch_value BpsLeadingNameMatch_value;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.lname_trailing_value   lname_trailing_value;
		AutoHeaderI.Types.fname_trailing_value   fname_trailing_value;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.prange_beg_value       prange_beg_value;
		AutoHeaderI.Types.prange_end_value       prange_end_value;
		AutoHeaderI.Types.prange_wild_value      prange_wild_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.allow_date_seen_value  allow_date_seen_value;
		AutoHeaderI.Types.date_first_seen_value  date_first_seen_value;
		AutoHeaderI.Types.date_last_seen_value   date_last_seen_value;
		AutoHeaderI.Types.zip_val                zip_val;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.zipradius_value        zipradius_value;
		AutoHeaderI.Types.city_zip_value         city_zip_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.addr_range             addr_range;
		AutoHeaderI.Types.addr_wild              addr_wild;
		AutoHeaderI.Types.lname_val              lname_val;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_Address_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.SearchIgnoresAddressOnly_value SearchIgnoresAddressOnly_value;
		AutoHeaderI.Types.AllowLeadingLName_value AllowLeadingLname_value;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.prange_beg_value       prange_beg_value;
		AutoHeaderI.Types.prange_end_value       prange_end_value;
		AutoHeaderI.Types.prange_wild_value      prange_wild_value;
		AutoHeaderI.Types.sec_range_value        sec_range_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.allow_date_seen_value  allow_date_seen_value;
		AutoHeaderI.Types.date_first_seen_value  date_first_seen_value;
		AutoHeaderI.Types.date_last_seen_value   date_last_seen_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.addr_range             addr_range;
		AutoHeaderI.Types.addr_wild              addr_wild;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
	end;

	export Fetch_Hdr_Batch_Indv_Zip_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.non_exclusion_value    non_exclusion_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.county_value           county_value;
		AutoHeaderI.Types.BpsLeadingNameMatch_value BpsLeadingNameMatch_value;
		AutoHeaderI.Types.lname_trailing_value   lname_trailing_value;
		AutoHeaderI.Types.fname_trailing_value   fname_trailing_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.zip_val                zip_val;
		AutoHeaderI.Types.zipradius_value        zipradius_value;
		AutoHeaderI.Types.city_zip_value         city_zip_value;
		AutoHeaderI.Types.lname_val              lname_val;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_SSNPartial_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
	end;

	export Fetch_Hdr_Batch_Indv_ZipPRLname_Layout := record
		Fetch_Batch_Indv_ZipPRLname_Layout;
	end;

	export Fetch_Hdr_Batch_Indv_DA_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.lname4_value           lname4_value;
		AutoHeaderI.Types.fname3_value           fname3_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_DOBFname_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.dob_val                dob_val;
		AutoHeaderI.Types.agehigh_val            agehigh_val;
		AutoHeaderI.Types.agelow_val             agelow_val;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.fname_value            fname_value;
	end;

	export Fetch_Hdr_Batch_Indv_FnameSmall_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.allow_date_seen_value  allow_date_seen_value;
		AutoHeaderI.Types.date_first_seen_value  date_first_seen_value;
		AutoHeaderI.Types.date_last_seen_value   date_last_seen_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_Name_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.ln_branded_value       ln_branded_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.BpsLeadingNameMatch_value BpsLeadingNameMatch_value;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.lname_trailing_value   lname_trailing_value;
		AutoHeaderI.Types.fname_trailing_value   fname_trailing_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_StName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.non_exclusion_value    non_exclusion_value;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.BpsLeadingNameMatch_value BpsLeadingNameMatch_value;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.lname_trailing_value   lname_trailing_value;
		AutoHeaderI.Types.fname_trailing_value   fname_trailing_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.find_month             find_month;
		AutoHeaderI.Types.find_day               find_day;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.mname_value            mname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_StCityName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.isCRS                  isCRS;
		AutoHeaderI.Types.ssn_value              ssn_value;
		AutoHeaderI.Types.did_value              did_value;
		AutoHeaderI.Types.BpsLeadingNameMatch_value BpsLeadingNameMatch_value;
		AutoHeaderI.Types.UsePhoneticDistance    UsePhoneticDistance;
		AutoHeaderI.Types.LNamePhoneticSet       LNamePhoneticSet;
		AutoHeaderI.Types.lname_trailing_value   lname_trailing_value;
		AutoHeaderI.Types.fname_trailing_value   fname_trailing_value;
		AutoHeaderI.Types.nicknames              nicknames;
		AutoHeaderI.Types.phonetics              phonetics;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.find_year_low          find_year_low;
		AutoHeaderI.Types.find_year_high         find_year_high;
		AutoHeaderI.Types.lname_value            lname_value;
		AutoHeaderI.Types.lname_set_value        lname_set_value;
		AutoHeaderI.Types.fname_value            fname_value;
		AutoHeaderI.Types.prev_state_val1        prev_state_val1;
		AutoHeaderI.Types.prev_state_val2        prev_state_val2;
		AutoHeaderI.Types.other_lname_value1     other_lname_value1;
		AutoHeaderI.Types.other_city_value       other_city_value;
		AutoHeaderI.Types.rel_fname_value1       rel_fname_value1;
		AutoHeaderI.Types.rel_fname_value2       rel_fname_value2;
	end;

	export Fetch_Hdr_Batch_Indv_Layout := record
		Fetch_Hdr_Batch_Indv_DID_Layout or
		Fetch_Hdr_Batch_Indv_RID_Layout or
		Fetch_Hdr_Batch_Indv_SSN_Layout or
		Fetch_Hdr_Batch_Indv_StNameSmall_Layout or
		Fetch_Hdr_Batch_Indv_Phone_Layout or
		Fetch_Hdr_Batch_Indv_Street_Layout or
		Fetch_Hdr_Batch_Indv_Address_Layout or
		Fetch_Hdr_Batch_Indv_Zip_Layout or
		Fetch_Hdr_Batch_Indv_SSNPartial_Layout or
		Fetch_Hdr_Batch_Indv_ZipPRLname_Layout or
		Fetch_Hdr_Batch_Indv_DA_Layout or
		Fetch_Hdr_Batch_Indv_DOBFname_Layout or
		Fetch_Hdr_Batch_Indv_FnameSmall_Layout or
		Fetch_Hdr_Batch_Indv_Name_Layout or
		Fetch_Hdr_Batch_Indv_StName_Layout or
		Fetch_Hdr_Batch_Indv_StCityName_Layout;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.any_addr_error_value   any_addr_error_value;
	end;
	
	export Fetch_Batch_Biz_Address_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.sec_range_value        sec_range_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.city_codes_set         city_codes_set;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_val                zip_val;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
		boolean                      isBareAddr;
	end;

	export Fetch_Batch_Biz_FEIN_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.fein_val               fein_val;
	end;

	export Fetch_Batch_Biz_Name_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
	end;

	export Fetch_Batch_Biz_NameWords_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.company_name_val_filt  company_name_val_filt;
		AutoHeaderI.Types.company_name_val_filt2 company_name_val_filt2;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
	end;

	export Fetch_Batch_Biz_Phone_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
	end;
	
	export Fetch_Batch_Biz_StCityName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
		boolean                      isBareAddr;
	end;

	export Fetch_Batch_Biz_StName_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
		boolean                      isBareAddr;
	end;

	export Fetch_Batch_Biz_Zip_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.lookup_value           lookup_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.comp_name_value        comp_name_value;
		AutoHeaderI.Types.comp_name_indic_value  comp_name_indic_value;
		AutoHeaderI.Types.comp_name_sec_value    comp_name_sec_value;
		boolean                      isBareAddr;
	end;
	
	export Fetch_Batch_Biz_Layout := record
		Fetch_Batch_Biz_Zip_Layout or
		Fetch_Batch_Biz_StName_Layout or
		Fetch_Batch_Biz_StCityName_Layout or
		Fetch_Batch_Biz_Phone_Layout or
		Fetch_Batch_Biz_NameWords_Layout or
		Fetch_Batch_Biz_Name_Layout or
		Fetch_Batch_Biz_FEIN_Layout or
		Fetch_Batch_Biz_Address_Layout;
	end;
	
	export Fetch_Hdr_Batch_Biz_Address_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.SearchIgnoresAddressOnly_value SearchIgnoresAddressOnly_value;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.sec_range_value        sec_range_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_Street_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.pname_value            pname_value;
		AutoHeaderI.Types.prange_value           prange_value;
		AutoHeaderI.Types.addr_loose             addr_loose;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_FEIN_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
	end;
	
	export Fetch_Hdr_Batch_Biz_Phone_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_Name_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_StCityName_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_StName_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.city_value             city_value;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_Zip_Layout := record, maxlength(16384)
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.nofail                 nofail;
		AutoHeaderI.Types.company_name_value     company_name_value;
		AutoHeaderI.Types.zip_value              zip_value;
		AutoHeaderI.Types.fein_value             fein_value;
		AutoHeaderI.Types.bdid_value             bdid_value;
		AutoHeaderI.Types.phone_value            phone_value;
		AutoHeaderI.Types.state_value            state_value;
		AutoHeaderI.Types.allow_close_match_value allow_close_match_value;
		AutoHeaderI.Types.allow_indic_match_value allow_indic_match_value;
		AutoHeaderI.Types.allow_wild_match_value allow_wild_match_value;
		boolean                      fein_mandatory_match;
		boolean                      phone_mandatory_match;
	end;
	
	export Fetch_Hdr_Batch_Biz_Layout := record, maxlength(16384)
		Fetch_Hdr_Batch_Biz_Address_Layout or
		Fetch_Hdr_Batch_Biz_Street_Layout or
		Fetch_Hdr_Batch_Biz_FEIN_Layout or
		Fetch_Hdr_Batch_Biz_Phone_Layout or
		Fetch_Hdr_Batch_Biz_Name_Layout or
		Fetch_Hdr_Batch_Biz_StCityName_Layout or
		Fetch_Hdr_Batch_Biz_StName_Layout or
		Fetch_Hdr_Batch_Biz_Zip_Layout;
		AutoHeaderI.Types.addr_error_value       addr_error_value;
		AutoHeaderI.Types.any_addr_error_value   any_addr_error_value;
	end;
	
	export Fetch_Batch_Layout := record, maxlength(16384)
		Fetch_Batch_Biz_Layout or
		Fetch_Batch_Indv_Layout;
		boolean workHard;
		boolean isCRS;
	end;
	
	export Fetch_Batch_PreOutput_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.ErrCode                errcode;
		string1                      idtype := '';
		unsigned6                    id;
	end;
	
	export Fetch_Batch_Postkey_Layout := record
		Fetch_Batch_PreOutput_Layout;
		boolean nonkeyedcondition;
	end;
	
	export Fetch_Batch_Output_Layout := record
		AutoHeaderI.Types.acctno                 acctno;
		AutoHeaderI.Types.ErrCode                errcode;
		unsigned6                    id;
		boolean                      isDid;
		boolean                      isBdid;
		boolean                      isFake;
	end;
	
	export Fetch_Output_Layout :=
		Fetch_Batch_Output_Layout - [acctno,errcode];
	
	export File_Hdr_Biz_Keybuild_Layout := record
		unsigned6  rcid;
		qstring10  prim_range;
		qstring28  prim_name;
		qstring8   sec_range;
		qstring25  city_name;
		unsigned4  city_code;
		qstring2   state;
		integer4   zip;
		qstring40  word;
		qstring40  indic;
		qstring40  sec;
		qstring120 cname;
		unsigned4  fein;
		string7    p7;
		string3    p3;
		unsigned6  bdid;
	end;
	
	export Key_Hdr_Biz_Address_Layout := record
		File_Hdr_Biz_Keybuild_Layout.prim_name;
		File_Hdr_Biz_Keybuild_Layout.prim_range;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.city_code;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.sec_range;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Street_Layout := record
		File_Hdr_Biz_Keybuild_Layout.prim_name;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.prim_range;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_FEIN_Layout := record
		string1 f1;
		string1 f2;
		string1 f3;
		string1 f4;
		string1 f5;
		string1 f6;
		string1 f7;
		string1 f8;
		string1 f9;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Phone_Layout := record
		File_Hdr_Biz_Keybuild_Layout.p7;
		File_Hdr_Biz_Keybuild_Layout.p3;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Name_Layout := record
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_StCityName_Layout := record
		File_Hdr_Biz_Keybuild_Layout.city_code;
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_StName_Layout := record
		File_Hdr_Biz_Keybuild_Layout.state;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Key_Hdr_Biz_Zip_Layout := record
		File_Hdr_Biz_Keybuild_Layout.zip;
		File_Hdr_Biz_Keybuild_Layout.word;
		File_Hdr_Biz_Keybuild_Layout.indic;
		File_Hdr_Biz_Keybuild_Layout.sec;
		File_Hdr_Biz_Keybuild_Layout.cname;
		File_Hdr_Biz_Keybuild_Layout.fein;
		File_Hdr_Biz_Keybuild_Layout.bdid;
	end;
	
	export Fetch_Combined_Layout := record
		Fetch_Hdr_Batch_Indv_Layout or
		Fetch_Hdr_Batch_Biz_Layout or
		Fetch_Batch_Layout;
	end;
	
	export Fetch_Hdr_Indv_DID_Layout := record
		unsigned6 DID;
	end;
	
	export Fetch_Hdr_Indv_Result_Layout := record
		AutoHeaderI.Types.ErrCode errcode;
		dataset(Fetch_Hdr_Indv_DID_Layout) dids {maxcount(ut.limits.FETCH_UNKEYED)};
	end;
	
	export Fetch_Hdr_Indv_Working_Layout := record
		Fetch_Hdr_Batch_Indv_Layout;
		Fetch_Hdr_Indv_Result_Layout results;
	end;
	
	export Fetch_Hdr_Biz_BDID_Layout := record
		unsigned6 BDID;
	end;
	
	export Fetch_Hdr_Biz_Result_Layout := record
		AutoHeaderI.Types.ErrCode errcode;
		dataset(Fetch_Hdr_Biz_BDID_Layout) bdids {maxcount(ut.limits.FETCH_UNKEYED)};
	end;
	
	export Fetch_Hdr_Biz_Working_Layout := record, maxlength(40000)
		Fetch_Hdr_Batch_Biz_Layout;
		string120 cleaned_cname;
		Fetch_Hdr_Biz_Result_Layout results;
	end;
	
	export Fetch_ID_Layout := record
		string1 idtype := '';
		unsigned ID;
	end;
	
	export Fetch_Result_Layout := record
		AutoHeaderI.Types.ErrCode errcode;
		dataset(Fetch_ID_Layout) ids {maxcount(ut.limits.FETCH_UNKEYED)};
	end;
	
	export Fetch_Working_Layout := record
		Fetch_Batch_Layout;
		Fetch_Result_Layout results;
	end;

end;
