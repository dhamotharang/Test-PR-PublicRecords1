export Layouts := MODULE
	export layout_lname := record
		QSTRING20 	lname;
		UNSIGNED3		date_name_first_seen;
	end;
	export layout_marriage_base := record
		UNSIGNED6 	did;
		STRING1			marital_status;
		QSTRING5    title;
		QSTRING20   fname;
		QSTRING20   mname;
		QSTRING20   lname;
		QSTRING20		best_lname;
		UNSIGNED6		spouse_did;
		UNSIGNED6		potential_spouse_did;
		QSTRING20		married_lname;
		QSTRING20		previous_lname;
		QSTRING5  	name_suffix;
		STRING10 		prim_range;
		STRING2  		predir;
		STRING28 		prim_name;
		STRING4  		suffix;
		STRING2  		postdir;
		STRING10 		unit_desig;
		STRING8  		sec_range;
		STRING25 		p_city_name;
		STRING2  		st;
		STRING5  		zip;
		STRING1  		gender;
		INTEGER4    dob;
		UNSIGNED1		age;
		BOOLEAN			name_change_event;
		UNSIGNED2		lname_cnt;
		UNSIGNED3		date_name_first_reported;
		UNSIGNED3		dt_first_seen;
		UNSIGNED3		dt_nonglb_last_seen;
		dataset(layout_lname) last_names{maxcount(20)};
	end;

//MSI V2	
	export rFinal_MD_Shell := record
		UNSIGNED6	did;
		STRING1		gender;
		INTEGER4	dob;
		UNSIGNED1	age;
		STRING20	fname;
		STRING20	lname;
		STRING10	prim_range;
		STRING2		predir;
		STRING28	prim_name;
		STRING8		sec_range;
		STRING30	city_name;
		STRING2		st;
		STRING5		zip;
		STRING10	best_prim_range;
		BOOLEAN		name_change;
		UNSIGNED2	lname_cnt := 1;
		STRING30	oldest_lname;
		STRING30	best_lname;
		BOOLEAN		rel_address;	//prim = prim or 0 or -3
		BOOLEAN		rel_addr_same_lname;	
		INTEGER4	rel_addr_recent_dt;	
		BOOLEAN		rel_shared_address;	//prim = prim or 0 or -3
		BOOLEAN		rel_shared_addr_same_lname;	
		INTEGER4	rel_shared_addr_recent_dt;	
		BOOLEAN		rel_vehicle;	//prim = -6
		BOOLEAN		rel_property;	//prim = -5
		BOOLEAN		rel_prop_same_lname;	
		INTEGER4	rel_prop_recent_dt;	
		BOOLEAN		rel_spouse;	//prim = -7
		INTEGER4	rel_spouse_recent_dt;
		BOOLEAN		rel_spouse_same_lname;	
		INTEGER4	spouse_dod;
		integer		parents;
		unsigned6	hhid;
		unsigned6 hhid_did1;
		STRING1		hhid_did1_gender;
		INTEGER4	hhid_did1_dob;
		unsigned6 hhid_did2;
		STRING1		hhid_did2_gender;
		INTEGER4	hhid_did2_dob;
		unsigned6 hhid_did3;
		STRING1		hhid_did3_gender;
		INTEGER4	hhid_did3_dob;
		unsigned6 hhid_did4;
		STRING1		hhid_did4_gender;
		INTEGER4	hhid_did4_dob;
		unsigned6 hhid_did5;
		STRING1		hhid_did5_gender;
		INTEGER4	hhid_did5_dob;
		Integer4	hhid_cnt;
		//spouse match variables
		STRING1	marital_status_v1;	//(W)idowed, (M)arried, (D)ivorced, (X)Deceased, (S)ibling (MDV1)
		unsigned6	record_id;
		INTEGER4	div_dt;
		INTEGER4	mar_dt;
		string1	filing_type;		 //current values are "3" for marriages and "7" for divorces "0" for unknown "1" for annulment
		INTEGER4	liens_recent_unreleased_count;
		boolean	bk_flag;
		BOOLEAN bankrupt := false;
		UNSIGNED1 filing_count;
		UNSIGNED1 bk_recent_count;
		boolean	rc_decsflag := false;
		// boolean	OwnedByAnother_Flag;
		boolean	CurrentPropertyOwner_Flag := false;
	end;
	export rMSIV2 := record
		rFinal_MD_Shell;
		integer4	ts_recent_addr_dt;
		integer4	ts_shared_addr_dt;
		integer4	ts_sp_recent_dt;
		boolean		ts_sp_recent_miss;
		integer4	recent_addr_dt;
		integer4	shared_addr_dt;
		integer4	sp_recent_dt;
		integer4	age1;
		integer4	age2;
		integer4	age3;
		integer4	age4;
		integer4	age5;
		integer4	age_chg_1;
		integer4	age_chg_2;
		integer4	age_chg_3;
		integer4	age_chg_4;
		integer4	age_chg_5;
		integer4	sex;
		integer4	fm_hhid;
		integer4	lienBK;
		integer4	spouse;
		integer4	parent;
		string2	marital_status_v2;
		boolean	potential_roommate;
	end;

end;