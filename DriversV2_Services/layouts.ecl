import DriversV2, doxie, doxie_build;

export layouts := module
	
	export key_dl					:= DriversV2.Key_DL_Seq;
	export key_conviction	:= DriversV2.Key_DL_Conviction_DLCPKey;
	export key_suspension	:= DriversV2.Key_DL_Suspension_DLCPKey;
	export key_drinfo			:= DriversV2.Key_DL_DR_Info_DLCPKey;
	export key_accident		:= DriversV2.Key_DL_Accident_DLCPKey;
	export key_insurance	:= DriversV2.Key_DL_FRA_Insurance_DLCPKey;
	
	export src := record
		key_dl;
	end;
	
	export seq := record
		key_dl.dl_seq;
	end;
	
	export search_ids := record
		seq;
		boolean isDeepDive := false;
	end;
	
	export num := record
		key_dl.dl_number;
	end;
	
	export snum := record
		key_dl.dl_number;
		key_dl.orig_state;
	end;

	export did := doxie.layout_references;
	
	export pen := record
		unsigned2 penalt;
	end;
	
	export name := module
		export narrow := record
			key_dl.name;
			key_dl.title;
			key_dl.fname;
			key_dl.mname;
			key_dl.lname;
			key_dl.name_suffix;
		end;
		export wide := record
			narrow;
			key_dl.name_change;
		end;
	end;
	
	export address := module
		export narrow := record			
			key_dl.addr1;
			key_dl.city;
			key_dl.state;
			key_dl.zip;
			
			key_dl.prim_range;
			key_dl.predir;
			key_dl.prim_name;
			key_dl.suffix;
			key_dl.postdir;
			key_dl.unit_desig;
			key_dl.sec_range;
			key_dl.p_city_name;
			key_dl.v_city_name;
			key_dl.st;
			key_dl.zip5;
			key_dl.zip4;
		end;
		export wide := record
			narrow;
			key_dl.address_change;
			key_dl.country;
			key_dl.postal_code;
			key_dl.province;
		end;
	end;
	
	export individual := module
		export narrow := record
			key_dl.did;							// needed for suppression
			key_dl.dob;
			key_dl.race;
			key_dl.sex_flag;
			key_dl.ssn;
			key_dl.height;
			key_dl.hair_color;
			key_dl.eye_color;
			key_dl.weight;
			key_dl.history;
			
			// derived fields
			string20	race_name;				// max=15
			string10	sex_name;					// max=7
			string10	hair_color_name;	// max=9
			string15	eye_color_name;		// max=11
			string10	history_name;			// max=10
		end;
		export wide := record
			narrow;
			key_dl.dod;
			key_dl.age;
			key_dl.privacy_flag;		// needed for DPPA
		end;
	end;
	
	export DLinfo := module
		export narrow := record
			key_dl.license_type;
			key_dl.license_class;
			key_dl.status;
			key_dl.cdl_status;
			key_dl.attention_flag;
			key_dl.lic_issue_date;
			key_dl.expiration_date;			
			key_dl.motorcycle_code;
			key_dl.dl_number;
			key_dl.orig_state;			// listed as "state_origin" in spreadsheet
			key_dl.county;
			key_dl.rec_type;
			key_dl.restrictions_delimited;
			key_dl.lic_endorsement;
			key_dl.oos_previous_dl_number;
			key_dl.oos_previous_st;
			
			// derived fields
			string75	license_type_name;	// max=69
			string250 license_class_name;	// max=241
			string50	status_name;				// max=33
			string50	cdl_status_name;		// max=33
			string25	attention_name;			// max=22
  		string20	orig_state_name;		// max=20
			string18	county_name;				// max=18
			string120	restriction1;				// max=107
			string120	restriction2;				// max=107
			string120	restriction3;				// max=107
			string120	restriction4;				// max=107
			string120	restriction5;				// max=107
			string135 endorsement1;				// max=131
			string135 endorsement2;				// max=131
			string135 endorsement3;				// max=131
			string135 endorsement4;				// max=131
			string135 endorsement5;				// max=131
		end;
		export wide := record
			narrow;
			key_dl.orig_expiration_date;
			key_dl.orig_issue_date;
			key_dl.active_date;
			key_dl.inactive_date;
			key_dl.issuance;
			key_dl.old_dl_number;
			
			// derived fields
			unsigned1 age_today;
			unsigned1 dead_age;
		end;
	end;
	
	export result_narrow := record
		seq;
		pen;
		string9 source_code;
		string1 nonDMVsource;
		unsigned8 dt_first_seen;
		unsigned8 dt_last_seen;
		name.narrow;
		address.narrow;
		individual.narrow;
		DLinfo.narrow;
	end;
	
	export result_wide := record
		seq;
		pen;
		string9 source_code;
		string1 nonDMVsource;
		unsigned8 dt_first_seen;
		unsigned8 dt_last_seen;
		name.wide;
		address.wide;
		individual.wide;
		DLinfo.wide;
 	  integer2 addr_no := 0;
	end;
	export result_wide_tmp := record
		result_wide;
		
		// This is needed to join with the CP keys
		key_dl.dlcp_key;
		
		// These are all needed for MOXIE
		key_dl.Preglb_did; // STUB - is this right?
		key_dl.cleaning_score;
		key_dl.addr_fix_flag;
		key_dl.cart;
		key_dl.cr_sort_sz;
		key_dl.lot;
		key_dl.lot_order;
		key_dl.dpbc;
		key_dl.chk_digit;
		key_dl.ace_fips_st;
		key_dl.geo_lat;
		key_dl.geo_long;
		key_dl.msa;
		key_dl.geo_blk;
		key_dl.geo_match;
		key_dl.err_stat;
		key_dl.dob_change;
		key_dl.sex_change;
		key_dl.driver_edu_code;
		key_dl.dup_lic_count;
		key_dl.rcd_stat_flag;
		key_dl.dl_key_number;
		key_dl.restrictions;
		key_dl.moxie_license_type;
		
		// and these are needed for legacy
		key_dl.dt_vendor_first_reported;
		key_dl.dt_vendor_last_reported;
		key_dl.record_type;
		key_dl.ssn_safe;
	end;
	
	// conviction points
	export cp := module
		export conviction := record
			key_conviction.type_cd;								// "type"
			key_conviction.type_desc;
			key_conviction.violation_date;
			key_conviction.plate_nbr;
			key_conviction.conviction_date;
			key_conviction.court_name_cd;
			key_conviction.court_name_desc;
			key_conviction.court_county;
			key_conviction.court_type_cd;					// "court_type"
			key_conviction.court_type_desc;				// "court_type"
			key_conviction.st_offense_conv_cd;		// "offense"
			key_conviction.st_offense_conv_desc;	// "offense"
			key_conviction.sentence;
			key_conviction.sentence_desc;
			key_conviction.points;
			key_conviction.hazardous_cd;
			key_conviction.hazardous_desc;
			key_conviction.plea_cd;								// "plea"
			key_conviction.plea_desc;							// "plea"
			key_conviction.court_case_nbr;
			key_conviction.acd_offense_cd;				// "offense_code"
			key_conviction.acd_offense_desc;			// "offense_desc"
			key_conviction.vehicle_no;
			key_conviction.reduced_cd;
			key_conviction.reduced_desc;
			key_conviction.create_date;
			key_conviction.bmv_case_nbr_1;
			key_conviction.bmv_case_nbr_2;
			key_conviction.bmv_case_nbr_3;
			key_conviction.habitual_case_nbr;
			key_conviction.filed_date;
			key_conviction.expunged_date;
			key_conviction.jurisdiction;
			key_conviction.soa_conviction;
			key_conviction.bmv_sp_case_nbr;
			key_conviction.out_of_state_dl_nbr;
			key_conviction.state_of_origin;
			key_conviction.county;
		end;
		
		export suspension := record
			key_suspension.type_cd;								// "type"
			key_suspension.type_desc;
			key_suspension.violation_date;
			key_suspension.clear_date;
			key_suspension.filed_date;
			key_suspension.action_date;
			key_suspension.start_date;
			key_suspension.end_date;
			key_suspension.bmv_case_nbr_1;
			key_suspension.court_case_nbr;
			key_suspension.court_name_cd;					// "court_name_code"
			key_suspension.court_name_desc;				// "court_name_code"
			key_suspension.court_county;
			key_suspension.court_type;
			key_suspension.st_offense_conv_cd;		// "offense_conv"
			key_suspension.st_offense_conv_desc;	// "offense_desc"
			key_suspension.vehicle_no_cd;
			key_suspension.vehicle_no_desc;
			key_suspension.hazardous_cd;
			key_suspension.hazardous_desc;
			key_suspension.jurisdiction;
			key_suspension.fee_pd_date;
			key_suspension.plate_nbr;
			key_suspension.cdl_disq_reason_cd;
			key_suspension.cdl_disq_reason_desc;
			key_suspension.cdl_ofs_disqual_reason_cd;
			key_suspension.cdl_ofs_disqual_reason_desc;
			key_suspension.disq_ext_cd;
			key_suspension.disq_ext_desc;
			key_suspension.disq_reason_ref;
			key_suspension.disq_reason_desc;
			key_suspension.sd_nbr;
			key_suspension.wd_clear_reason_cd;
			key_suspension.wd_clear_reason_desc;
			key_suspension.naic_ins_cd;						// "naic_ins_code"
			key_suspension.naic_ins_desc;					// "naic_ins_code"
			key_suspension.ins_bnd_filing_ind;
			key_suspension.cleared_date;
			key_suspension.wd_reason_cd;
			key_suspension.wd_reason_desc;
			key_suspension.remedial_drv_crs_dt;
			key_suspension.exam_date;
			key_suspension.acd_offense_cd;
			key_suspension.acd_offense_desc;
			key_suspension.wd_status_cd;
			key_suspension.wd_status_desc;
			key_suspension.mod_drv_date;
			key_suspension.settle_agree_date;
			key_suspension.restriction_cd;
			key_suspension.restriction_desc;
			key_suspension.conviction_date;
			key_suspension.appeal_file_date;
			key_suspension.appeal_deny_date;
			key_suspension.appeal_granted_date;
			key_suspension.plea_cd;
			key_suspension.plea_desc;
			key_suspension.suspension_revocation;
			key_suspension.county_cd;
			key_suspension.county_desc;
			key_suspension.arrest_date;
			key_suspension.license_number;
			key_suspension.create_date;
			key_suspension.license_rec_date;
			key_suspension.plate_rec_date;
			key_suspension.fra_sup_start_date;
			key_suspension.fra_sup_end_date;
			key_suspension.accident_date;
			key_suspension.related_bmv_case_nbr;
			key_suspension.narrative_cd;
			key_suspension.narrative_desc;
			key_suspension.fee_required;
			key_suspension.vehicle_owner_ind;
			key_suspension.soa_conviction;
			key_suspension.expunged_date;
			key_suspension.modified_drv_end_dt;
			key_suspension.appeal_sup_stay;
			key_suspension.wd_type_detail;
			key_suspension.hp_license_cancel;
			key_suspension.bmv_dl_case_nbr;
			key_suspension.related_bmv_case_nbr_2;
			key_suspension.fine_paid_date;				// "fine_paid"
			key_suspension.csea;
			key_suspension.csea_case_nbr;
			key_suspension.csea_order_nbr;
			key_suspension.csea_part_nbr;
		end;
		
		export drinfo := record
			key_drinfo.action_date;
			key_drinfo.bmv_case_nbr_1;
			key_drinfo.clear_date;
			key_drinfo.cosigners_dl_nbr;
			key_drinfo.cosigners_name;
			key_drinfo.cosigners_relationship;
			key_drinfo.court_case_nbr;
			key_drinfo.create_date;
			key_drinfo.dl_nbr;
			key_drinfo.expunged_date;
			key_drinfo.mailed_date;
			key_drinfo.narrative;
			key_drinfo.out_of_state_dl_nbr;
			key_drinfo.remedial_require_comp;
			key_drinfo.remedial_require_denied;
			key_drinfo.type_cd;
			key_drinfo.type_desc;
			key_drinfo.warrant_eff_date;
		end;
		
		export accident := record
			key_accident.type_cd;
			key_accident.type_desc;
			key_accident.county;
			key_accident.jurisdiction;
			string18	county_name :='';				// max=18
			key_accident.severity_cd;
			key_accident.severity_desc;
			key_accident.accident_date;
			key_accident.vehicle_no;
			key_accident.hazardous_cd;
			key_accident.hazardous_desc;
			key_accident.create_date;
			key_accident.bmv_case_nbr_1;
			key_accident.expunged_date;
		end;
		
		export insurance := record
			key_insurance.cancel_posted_date;
			key_insurance.create_date;
			key_insurance.filed_date;
			key_insurance.ins_cancel_dt;
			key_insurance.ins_policy_nbr;
			key_insurance.insurance_co_cd;
			key_insurance.insurance_co_desc;
			key_insurance.latest_proof_start_dt;
			key_insurance.proof_end_date;
			key_insurance.proof_start_date;
		end;
	end;

	export max_dl						:= 100;
	export max_dlcp_raw			:= 1000;
	export max_convictions	:= 200; // 470 - 5/27/08
	export max_suspensions	:= 200; // 872 - 5/27/08
	export max_drinfo				:= 200; // 317 - 5/27/08
	export max_accidents		:= 200; //  46 - 5/27/08
	export max_insurance		:= 200; // 253 - 5/27/08
	
	// Actual counts generated with...
	// output( choosen( sort( table( pull(key_conviction), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
	// output( choosen( sort( table( pull(key_suspension), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
	// output( choosen( sort( table( pull(key_drinfo), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
	// output( choosen( sort( table( pull(key_accident), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
	// output( choosen( sort( table( pull(key_insurance), {DLCP_Key, cnt:=count(group)}, DLCP_Key, many, unsorted ), -cnt), 1) );
	
	export result_rolled := record
		key_dl.dlcp_key;
		dataset(result_wide)		dl						{ maxcount(max_dl)					};
		dataset(cp.conviction)	Convictions		{ maxcount(max_convictions)	};
		dataset(cp.suspension)	Suspensions		{ maxcount(max_suspensions)	};
		dataset(cp.drinfo)			DR_Info				{ maxcount(max_drinfo)			};
		dataset(cp.accident)		Accidents			{ maxcount(max_accidents)		};
		dataset(cp.insurance) 	FRA_Insurance	{ maxcount(max_insurance)		};
	end;
	
	// This layout is supplied by Lee, defining output for the moxie services
	export Layout_drivers_license2_1 := record
		string12  	did;
		string12  	pgid;
		string1   	history;
		string2   	state_origin;
		string2   	source_code;
		string52  	name;
		string40  	addr1;
		string20  	city;
		string2   	state;
		string5   	zip;
		string8   	dob;
		string1   	race;
		string1   	sex_flag;
		string4   	license_type;
		string14  	attention_flag;
		string8   	dod;
		string42  	restrictions;
		string42  	restrictions_delimited;
		string8   	expiration_date;
		string8   	lic_issue_date;
		string10  	lic_endorsement;
		string4   	motorcycle_code;
		string24  	dl_number;
		string9   	ssn;
		string3   	age;
		string1   	privacy_flag;
		string8   	dl_orig_issue_date;
		string3   	height;
		string25  	oos_previous_dl_number;
		string2   	oos_previous_st;
		string5   	title;
		string20  	fname;
		string20  	mname;
		string20  	lname;
		string5   	name_suffix;
		string3   	cleaning_score;
		string1   	addr_fix_flag;
		string10  	prim_range;
		string2   	predir;
		string28  	prim_name;
		string4   	suffix;
		string2   	postdir;
		string10  	unit_desig;
		string8   	sec_range;
		string25  	p_city_name;
		string25  	v_city_name;
		string2   	st;
		string5   	zip5;
		string4   	zip4;
		string4   	cart;
		string1   	cr_sort_sz;
		string4   	lot;
		string1   	lot_order;
		string2   	dpbc;
		string1   	chk_digit;
		string2   	rec_type;
		string2   	ace_fips_st;
		string3   	county;
		string10  	geo_lat;
		string11  	geo_long;
		string4   	msa;
		string7   	geo_blk;
		string1   	geo_match;
		string4   	err_stat;
		string1   	status;
		string2   	issuance;
		string8   	address_change;
		string1   	name_change;
		string1   	dob_change;
		string1   	sex_change;
		string24  	old_dl_number;
		string1   	driver_edu_code;
		string1   	dup_lic_count;
		string1   	rcd_stat_flag;
		string3   	hair_color;
		string3   	eye_color;
		string3   	weight;
		string9   	dl_key_number;
	end;
	
	// Extra fields are used for deduping, then thinned back out before delivery
	export moxie_tmp := record
		Layout_drivers_license2_1;
		string10 history_name;
	end;
end;