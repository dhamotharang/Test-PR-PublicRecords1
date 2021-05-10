IMPORT AID, MCI;

EXPORT Layouts_V2 := MODULE
	
	EXPORT from_batch := RECORD
		string12		batch_seq_number;
		unsigned8		input_lexid;
		string50		input_crk;
		string50		member_id;
		string50		customer_id;
		string50		account_id;
		string50		subscriber_id;
		string50		group_id;
		string2			relationship_code;
		string50		input_first_name;
		string50		input_middle_initial;
		string50		input_last_name;
		string10		input_suffix;
		string150		input_full_name;
		string100		address_line1;
		string100		address_line2;
		string50		input_city;
		string2			input_state;
		string10		input_zip;
		string10		input_dob;
		string1			input_gender;
		string9			input_ssn;
		string14		input_home_phone;
		string14		input_alt_phone;
		string50		input_primary_email_address;
		string50		input_guardian_first_name;
		string50		input_guardian_last_name;
		string10		input_guardian_dob;
		string9			input_guardian_ssn;
		string100		udf1;
		string100		udf2;
		string100		udf3;
		string10 		title;
		string50 		fname;
		string50 		mname;
		string50 		lname;
		string10 		suffix;
		unsigned4		dob;
		string1 		gender;
		string9 		ssn;
		string10		home_phone;
		string10		alt_phone;
		string50		primary_email_address;
		string10 		prim_range;
		string2     predir;	
		string28    prim_name;	
		string4     addr_suffix;  	
		string2     postdir;	
		string10 		unit_desig;	
		string8 		sec_range;	
		string25		city_name;	
		string2 		st;	
		string5			zip;	
		string4     zip4;	
		string2 		rec_type;	
		string5 		county;	
		string10		geo_lat;	
		string11		geo_long;	
		string4			msa;	
		string7			geo_blk;	
		string1			geo_match;	
		string4			err_stat;	
		string50 		guardian_fname;//	Guardian First Name - cleaned
		string50 		guardian_mname;//	Guardian middle Name  - cleaned
		string50 		guardian_lname;//	Guardian Last Name - cleaned
		unsigned4		guardian_dob; 
		string9			guardian_ssn;
		string3			calc_age;
	END;
			
	EXPORT Base := RECORD
		from_batch;
		unsigned8		Source_rid;
		string50		Persistent_rid;
		unsigned8		RID;
		string10 		Src;
		unsigned4		dt_first_seen;
		unsigned4		dt_last_seen;
		unsigned4		dt_vendor_first_reported;
		unsigned4		dt_vendor_last_reported;
		string20		preferred_name;
		unsigned8		nomatch_id;
		string50		crk;
		unsigned8		Lexid;
		unsigned1		Lexid_score;
		unsigned8		guardian_Lexid;
		unsigned1		guardian_Lexid_score;
		string1			crk_changed;
		string1			Lexid_changed;		
		string50		prev_crk;
		unsigned8		prev_Lexid;
		string1			history_or_current;
		unsigned4		startdate; // place holder for point-in-time
		unsigned4		enddate; // place holder for point-in-time
		string1			history_mode;	// A - keep all, N - keep none
		unsigned1		runtime_threshold; // lexid threshold passed at run time
		string1			append_option ; // see note below
    unsigned4 	global_sid  :=  0;
    unsigned8 	record_sid  :=  0;
		AID.Common.xAID	RawAID;
		AID.Common.xAID	ACEAID;	
		string100		gcid_name;
		string10		batch_jobid;
		//AppendOption:
		// 1 - Append LexID to records with LexID match AND Customer Record Key for all records
		// 2 - Append LexID to records with LexID match AND Customer Record Key ONLY for records with NO LEXID
		// 3 - Append LexID ONLY to records with LexID match and DO NOT append Customer Record Key for any records
		// 4 - Append ONLY Customer Record Key for all records - NO LEXID appends for any records
	END;
	
	EXPORT Input_processing := RECORD
		base;
		string1	current_input;
	END;
	
	EXPORT to_batch		:= RECORD
		base.batch_seq_number;
		base.input_lexid;
		base.input_crk;
		base.member_id;
		base.customer_id;
		base.account_id;
		base.subscriber_id;
		base.group_id;
		base.relationship_code;
		base.input_first_name;
		base.input_middle_initial;
		base.input_last_name;
		base.input_suffix;
		base.input_full_name;
		base.address_line1;
		base.address_line2;
		base.input_city;
		base.input_state;
		base.input_zip;
		base.input_dob;
		base.input_gender;
		base.input_ssn;
		base.input_home_phone;
		base.input_alt_phone;
		base.input_primary_email_address;
		base.input_guardian_first_name;
		base.input_guardian_last_name;
		base.input_guardian_dob;
		base.input_guardian_ssn;
		base.udf1;
		base.udf2;
		base.udf3;
		base.calc_age;
		base.lexid; 
		base.lexid_score; 
		base.lexid_changed; 
		base.prev_lexid; 
		base.crk;
		base.crk_changed;
		base.prev_crk;
	end;
	
	EXPORT as_header	:= RECORD
		base.nomatch_id;
		base.rid;
		base.lexid;
		base.lexid_score;
		base.guardian_lexid;
		base.guardian_lexid_score;
		base.crk;
		base.src;
		base.gcid_name;
		base.source_rid;
		base.dt_first_seen;
		base.dt_last_seen;
		base.dt_vendor_first_reported;
		base.dt_vendor_last_reported;
		base.member_id;
		base.customer_id;
		base.account_id;
		base.subscriber_id;
		base.group_id;
		base.relationship_code;
		base.title;
		base.fname;
		base.mname;
		base.lname;
		base.suffix;
		base.input_full_name;
		base.dob;
		base.gender;
		base.ssn;
		base.home_phone;
		base.alt_phone;
		base.primary_email_address;
		base.prim_range;
		base.predir;
		base.prim_name;
		base.addr_suffix;
		base.postdir;
		base.unit_desig;
		base.sec_range;
		base.city_name;
		base.st;
		base.zip;
		base.zip4;
		base.rec_type;
		base.county;
		base.geo_lat;
		base.geo_long;
		base.msa;
		base.geo_blk;
		base.geo_match;
		base.err_stat;
		base.guardian_fname;
		base.guardian_mname;
		base.guardian_lname;
		base.guardian_dob;
		base.guardian_ssn;
		base.udf1;
		base.udf2;
		base.udf3;
		base.persistent_rid;
		base.global_sid;
		base.record_sid;
		base.batch_jobid;
		base.batch_seq_number;
		base.Lexid_changed;
		typeof(base.prev_lexid) old_lexid;
		base.crk_changed;
		typeof(base.prev_crk) old_crk;
	END;
	
	EXPORT temp_header := record
		as_header;
		unsigned1	__tpe;
	END;
		
	EXPORT metrics_fields	:= RECORD
		unsigned1		min_lexid_score;
		unsigned1		max_lexid_score;
		unsigned1		ave_lexid_score;
		unsigned4		cnt_lexid_change;
		unsigned1		pct_lexid_change;
		unsigned4		cnt_crk_change;
		unsigned1		pct_crk_change;
		unsigned1		guardian_min_lexid_score;
		unsigned1		guardian_max_lexid_score;
		unsigned1		guardian_ave_lexid_score;
		unsigned4		cnt_new_crk;
	END;
	
	EXPORT slim_history := RECORD
		base.batch_jobid;
		base.dt_vendor_last_reported;
		base.source_rid;
		base.input_crk;
		base.crk;
		base.crk_changed;
		base.input_lexid;
		base.lexid;
		base.lexid_score;
		base.lexid_changed;
		base.prev_Lexid;
		base.prev_crk;
	END;
	
	EXPORT aggregate_fields := RECORD
		unsigned1	min_lexid_score;
		unsigned1	max_lexid_score;
		unsigned1	ave_lexid_score;
		unsigned4	cnt_lexid_change;
		unsigned1	pct_lexid_change; 
		unsigned4	distinct_lexid_cnt;
		unsigned4	dup_lexid_cnt;
		unsigned4	cnt_crk_change;
		unsigned1	pct_crk_change;
		unsigned4	distinct_crk_cnt; 
		unsigned4	dup_crk_cnt;
		unsigned4	new_crk_cnt;
		unsigned4	match_crk_cnt;
	END;
	
	EXPORT jobID_list := RECORD
		base.batch_jobid;
	END;

END;