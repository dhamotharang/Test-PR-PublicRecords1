
// NOTE: At the beginning of the M&D rewrite, we implemented a separate
//       MDSearchService and MDReportService.  Later a decision was made
//       to have only a single service, but you'll still see "narrow"
//       and "wide" in the layouts and elsewhere as an artifact of the
//       original implementation.  Today, we only use "wide".

import doxie, BatchShare, FFD;

export layouts := module

	shared k_main		:= keys.main();
	shared k_search	:= keys.search();
	shared k_did		:= keys.did();
	shared k_fnum		:= keys.fnum;
	
	export expanded_id := record
		k_main.record_id;
		typeof(k_did.did) search_did := 0;
		FFD.Layouts.CommonRawRecordElements;
	end;
	
	export l_id := record
		k_main.record_id;
	end;
	
	export search_ids := record
		l_id;
		boolean isDeepDive := false;
	end;
	
	export l_did := record
		k_did.did;
	end;
	
	export l_fnum := record
		k_fnum.filing_number;
		k_fnum.state_origin;
		k_fnum.county;
	end;
	
	export filing := record
		k_main.filing_type;
		string10 filing_type_name := ''; // actual max = 8
		k_main.state_origin;
		string20 state_origin_name := '';
		typeof(k_main.marriage_filing_dt)			filing_dt;
		typeof(k_main.marriage_filing_number)	filing_number;
	end;
	
	export pparty := record //a subset of marriage_divorce_v2/layout_mar_div_search
		k_search.did;
		k_search.party_type;
		string20 party_type_name := ''; // actual max = 17
		k_search.title;
		k_search.fname;
		k_search.mname;
		k_search.lname;
		k_search.name_suffix;
		k_search.nameasis_name_format;
		k_search.nameasis;
		k_search.prim_range;
		k_search.predir;
		k_search.prim_name;
		k_search.suffix;
		k_search.postdir;
		k_search.unit_desig;
		k_search.sec_range;
		k_search.p_city_name;
		k_search.v_city_name;
		k_search.st;
		k_search.zip;
		k_search.zip4;
		k_search.county;
		string20 county_name; // actual max = 18
		k_search.geo_lat;
		k_search.geo_long;
		k_search.geo_blk;
		k_search.geo_match;
	end;
	
	export party_combined := module
		export wide := record
			typeof(k_search.nameasis)		name;
			typeof(k_search.age)			age;
			string50			csz;
			typeof(k_search.nameasis)										alias;
			typeof(k_search.dob)											dob;
			typeof(k_search.birth_state)							birth_state;
			typeof(k_search.race)										race;
			string50										addr1;
			typeof(k_search.previous_marital_status)	previous_marital_status;
			typeof(k_search.how_marriage_ended)			how_marriage_ended;
			typeof(k_search.times_married)						times_married;
			pparty;
			FFD.Layouts.CommonRawRecordElements;
		end;
	end;
	
	shared marriage := record
		k_main.marriage_dt;
		k_main.marriage_county;
		k_main.marriage_city;
		k_main.place_of_marriage;
		k_main.type_of_ceremony;
	end;

	shared divorce := record
		k_main.number_of_children;
		k_main.divorce_county;
		k_main.grounds_for_divorce;
		k_main.divorce_dt;
	end;

	export result := module
		export wide := record
      k_main.record_id;
      boolean		isDeepDive := false;
      unsigned2 penalt;
			filing;
			party_combined.wide party1;
			party_combined.wide party2;
			marriage;
			divorce;
			FFD.Layouts.CommonRawRecordElements;
		end;
		export wide_tmp := record
			wide;
			
			// needed for moxie
			k_main.vendor;
			k_main.source_file;
			k_main.process_date;
			typeof(k_search.nameasis_name_format) party1_name_format;
			typeof(k_search.times_married) party1_times_married;
			typeof(k_search.race) party1_race;
			typeof(k_search.nameasis_name_format) party2_name_format;
			typeof(k_search.times_married) party2_times_married;
			typeof(k_search.race) party2_race;
			k_main.marriage_duration;
			unsigned6 search_did :=0;
		end;
	end;

	// This layout is supplied by Lee, defining output for the moxie find service
	export marriage_divorce2_1 := record
		string5   	vendor;
		string25  	source_file;
		string8   	process_date;
		string2   	state_origin;
		string10  	source_location_cd;
		string50  	source_county;
		string50  	source_city;
		string50  	filing_number;
		string1   	filing_type;
		string8   	filing_dt;
		string10  	party1_type;
		unsigned6  	party1_did;
		string70  	party1_orig_name;
		string70  	party1_orig_name_alias;
		string1   	party1_name_fmt;
		string8   	party1_dob;
		string9   	party1_ssn;
		string3   	party1_age;
		string10  	party1_residence_cds;
		string2   	party1_residence_state;
		string50  	party1_residence_city;
		string9   	party1_orig_zip;
		string50  	party1_residence_county;
		string75  	party1_residence_address1;
		string10  	party1_status_cd;
		string50  	party1_status;
		string2   	party1_times_married;
		string10  	party1_race_cd;
		string30  	party1_race;
		string10  	party2_type;
		unsigned6  	party2_did;
		string70  	party2_orig_name;
		string70  	party2_orig_name_alias;
		string1   	party2_name_fmt;
		string8   	party2_dob;
		string9   	party2_ssn;
		string3   	party2_age;
		string10  	party2_residence_cds;
		string2   	party2_residence_state;
		string50  	party2_residence_city;
		string9   	party2_orig_zip;
		string50  	party2_residence_county;
		string75  	party2_residence_address1;
		string10  	party2_status_cd;
		string50  	party2_status;
		string2   	party2_times_married;
		string10  	party2_race_cd;
		string30  	party2_race;
		string2   	number_children;
		string8   	marriage_dt;
		string8   	divorce_dt;
		string4   	marriage_months_duration;
		string10  	divorce_granted_to_cd;
		string30  	divorce_granted_to;
		string10  	divorce_grounds_cd;
		string50  	divorce_grounds;
		string5   	p1_title;
		string20  	p1_fname;
		string20  	p1_mname;
		string20  	p1_lname;
		string5   	p1_name_suffix;
		string3   	p1_score_in;
		string5   	p1a_title;
		string20  	p1a_fname;
		string20  	p1a_mname;
		string20  	p1a_lname;
		string5   	p1a_name_suffix;
		string3   	p1a_score_in;
		string5   	p2_title;
		string20  	p2_fname;
		string20  	p2_mname;
		string20  	p2_lname;
		string5   	p2_name_suffix;
		string3   	p2_score_in;
		string5   	p2a_title;
		string20  	p2a_fname;
		string20  	p2a_mname;
		string20  	p2a_lname;
		string5   	p2a_name_suffix;
		string3   	p2a_score_in;
		string10  	prim_range_1;
		string2   	predir_1;
		string28  	prim_name_1;
		string4   	addr_suffix_1;
		string2   	postdir_1;
		string10  	unit_desig_1;
		string8   	sec_range_1;
		string25  	p_city_name_1;
		string25  	v_city_name_1;
		string2   	st_1;
		string5   	zip_1;
		string4   	zip4_1;
		string10  	prim_range_2;
		string2   	predir_2;
		string28  	prim_name_2;
		string4   	addr_suffix_2;
		string2   	postdir_2;
		string10  	unit_desig_2;
		string8   	sec_range_2;
		string25  	p_city_name_2;
		string25  	v_city_name_2;
		string2   	st_2;
		string5   	zip_2;
		string4   	zip4_2;
	end;


	export batch_in := RECORD
	  String8 filling_date;
  // New "shared" structures would be better to use, but it is missing phones  
  // BatchShare/Layouts/ShareAcct, ShareDid, ShareName, ShareAddress, SharePII;
		doxie.layout_inBatchMaster;
		BatchShare.Layouts.ShareAddress.addr; // some common batch procedures require address line 1
    // for the future: if we want to save certain errrors (for example, autokey-search), then 
    // input layout can be extended with BatchShare/layouts/ShareErrors;
	END;
    
  
  export batch_out_search := RECORD
		String12 record_id;
    unsigned6 search_did := 0;
		marriage_divorce2_1;
		dataset (FFD.Layouts.ConsumerStatementBatch) statements;
		unsigned SequenceNumber :=0;
  END;
  
  export batch_out := RECORD
	  Doxie.layout_inBatchMaster.acctno; // or BatchShare.Layouts.ShareAcct;
		String1 output_type;
		String12 record_id;
		marriage_divorce2_1;
    BatchShare.layouts.ShareErrors;
		batch_out_search.SequenceNumber;
		FFD.Layouts.ConsumerFlags;
    string12 inquiry_lexid := '';
	END;
	
	export batch_out_pre := record(batch_out)
    dataset (FFD.Layouts.ConsumerStatementBatch) statements;
	end;
  
end;