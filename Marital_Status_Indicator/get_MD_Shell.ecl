 import address, bankruptcyv3, daybatchpcnsr, doxie, doxie_files, header, LN_PropertyV2, marital_status_indicator, marriage_divorce_v2, models, risk_indicators, ut, watchdog;


export get_MD_shell(DATASET(recordof(marital_status_indicator.key_MSI_Best_did)) indata ) := FUNCTION

	//constants
	string today := ut.GetDate;

	//working layouts
	rDid := record
		unsigned did;
	end;
	rlname := record
		QSTRING20 	lname;
		UNSIGNED3		date_name_first_seen;
	end;
	rslim_header := record
		UNSIGNED6 	did;
		QSTRING5    title;
		QSTRING20   fname;
		QSTRING20   mname;
		QSTRING20   lname;
		QSTRING20		best_lname;
		QSTRING5  	name_suffix;
		STRING10		prim_range;
		STRING2			predir;
		STRING28		prim_name;
		STRING8			sec_range;
		STRING5			zip;
		STRING1  		gender;
		INTEGER4    dob;
		integer4		dod;
		UNSIGNED1		age;
		dataset(rlname) last_names{maxcount(100)};
		BOOLEAN			name_change;
		UNSIGNED2		lname_cnt;
		UNSIGNED3		date_name_first_reported;
		UNSIGNED3		dt_first_seen;
		UNSIGNED3		dt_nonglb_last_seen;
	end;

	layout_relatives := record
		STRING1			marital_status;
		STRING1			gender1;
		INTEGER4    dob1;
		QSTRING8    dod1;
		QSTRING20   lname1;
		QSTRING20   mname1;
		QSTRING20   fname1;
		STRING10		prim_range1;
		STRING8			sec_range1;
		recordof(doxie.Key_Relatives);
		STRING1			gender2;
		INTEGER4    dob2;
		QSTRING8    dod2;
		QSTRING20   lname2;
		QSTRING20   mname2;
		QSTRING20   fname2;
		STRING10		prim_range2;
		STRING8			sec_range2;
		INTEGER4		dob_diff;
	end;
	layout_hed := recordof(doxie.key_header);
	rHHID := record
		unsigned6	did;
		unsigned6 hhid_did;
		STRING1	hhid_did_gender;
		INTEGER4	hhid_did_dob;
	end;
	//


	//data sets
	dInData 		:= distribute(indata, did);
	fHeader 		:= distribute(doxie.Key_Header, s_did);
	fRelatives 	:= distribute(doxie.Key_Relatives, person1);
	did_lookup 	:= distribute(doxie.Key_Did_Lookups_v2, did);
	households 	:= distribute(doxie.Key_HHID_Did, hhid_relat);
	watchdog 		:= distribute(marital_status_indicator.key_MSI_best_did, did);
	pkMD_did 		:= distribute(marriage_divorce_v2.key_mar_div_did(false), did);
	pkMD_main 	:= distribute(marriage_divorce_v2.key_mar_div_id_main(false), record_id);
	MDV1 				:= distribute(Marital_Status_Indicator.file_MSI_V1, did);
	bankruptcy	:= distribute(BankruptcyV3.Key_bankruptcyV3_bocashell, did);
	liens				:= distribute(doxie_files.Key_Bocashell_Liens_and_Evictions_V2, did);
	property 		:= distribute(LN_PropertyV2.key_property_did(), s_did);//(source_code='OP');

	
	//Get header for sample
	//join sample dids to Header.File_Headers and grab up to 100 names per DID
	rslim_header addHeaderSample(dInData l, fHeader r) := transform
		self.did := l.did;
		self.title := r.title;
		self.fname := r.fname;
		self.lname := r.lname;
		self.name_suffix := r.name_suffix;
		self.dob := r.dob;
		self.dod := r.dod;
		self.last_names := dataset([{models.common.getw(r.lname, 1), r.dt_first_seen}], rlname);
		self.date_name_first_reported := r.dt_vendor_first_reported;
		self.dt_nonglb_last_seen := r.dt_nonglb_last_seen;
		self.dt_first_seen := r.dt_first_seen;
		self.lname_cnt := 1;
		self := [];
	end;

	header_sample := join(dInData, fHeader,
		left.did = right.s_did,
		addHeaderSample(left,right),Left Outer, local, keep(100));


	//consolidate last name child sets and sort from most recent to oldest
	names_oldest  := dedup(sort(header_sample(dt_first_seen <> 0), did, dt_first_seen, local), did, local);
	names_deduped := dedup(sort(header_sample(dt_first_seen <> 0), did, lname, dt_first_seen, local), did, lname, local);
	names_sorted := sort(names_deduped, did, -dt_first_seen, local);


	//collapse last name child record sets by last name using 86% match as threshold
	rslim_header namesRoll(rslim_header l, rslim_header r) := transform
		name_score := Risk_Indicators.LnameScore(l.lname, l.last_names[1].lname);
		self.last_names := if(name_score > 86, l.last_names + r.last_names, l.last_names);
		self := l;
	end;
	names_rolled := rollup(names_sorted, namesRoll(left,right), did, local);


	// infer gender and count last names
	rslim_header inferPersonDataInit(names_rolled l) := transform
		self.gender := if(l.title <> '', if(l.title ='MR', 'M', 'F'), if(l.name_suffix <>'', 'M', ''));
		self.lname_cnt := count(l.last_names);
		self := l;
	end;
	completeHeaderInit := project(names_rolled, inferPersonDataInit(left), local);


	// get missing genders from doxie.key_did_lookups
	rslim_header addBestGender(completeHeaderInit l, did_lookup r) := transform
		self.gender := if(l.gender in ['','N','U'] ,r.gender, l.gender);
		self := l;
		self := [];
	end;

	header_best_gender := join(completeHeaderInit, did_lookup,
		left.did = right.did,
		addBestGender(left, right), keep(1), local);


	// Determine last name change and infer gender and year based age
	rslim_header inferPersonData(header_best_gender l) := transform
		self.gender := map(l.gender in ['','N','U'] and l.title = 'MR' 			=> 'M',
											 l.gender in ['','N','U'] and l.name_suffix <> '' => 'M',
											 l.gender in ['','N','U'] and l.title ='MS'				=> 'F',
											 l.gender);				 
		self := l;
	end;
	completeHeader := project(header_best_gender, inferPersonData(left), local);

	marital_status_indicator.Layouts.rFinal_MD_Shell buildRecord(completeHeader l) := transform
		self.age := if(l.dob > 0,(integer)ut.getdate[1..4] - (integer)l.dob[1..4], 0);
		self.name_change := if(l.lname_cnt >=2 and l.gender in ['F', 'N'], TRUE, FALSE);
		self.lname_cnt := if(l.gender in ['F','N'], l.lname_cnt, 1);
		self.rc_decsflag := if(l.dod >0, true, false);
		self := l;
		self := [];
	end;

	DOB_age := project(completeHeader, buildRecord(left), local);


	// pull HHID details
	marital_status_indicator.Layouts.rFinal_MD_Shell getKeyDidLookup(DOB_age l, did_lookup r) := transform
		self.hhid := r.hhid;
		self.parents := r.parents;
		self := l;
	end;

	HHID_Details := join(DOB_age, did_lookup,
			left.did = right.did,
			getKeyDidLookup(left, right), left outer, keep(1), local);


// append oldest last name
	marital_status_indicator.Layouts.rFinal_MD_Shell getOldestLname(HHID_Details l, names_oldest r) := transform
		self.oldest_lname := r.lname;
		self := l;
	end;

	Oldest_LNames := join(HHID_Details, names_oldest,
			left.did = right.did,
			getOldestLname(left, right), left outer, keep(1), local);


	// join to header.best to get best last name and prim range
	marital_status_indicator.Layouts.rFinal_MD_Shell addBestLast(Oldest_LNames l, watchdog r) := transform
		self.fname := r.fname;
		self.lname := r.lname;
		self.prim_range := r.prim_range;
		self.predir := r.predir;
		self.prim_name := r.prim_name;
		self.sec_range := r.sec_range;
		self.city_name := r.city_name;
		self.st := r.st;
		self.zip := r.zip;
		self.best_lname := models.common.getw(r.lname, 1);
		self.best_prim_range := r.prim_range;
		birthday := if(l.dob = 0, r.dob, l.dob);
		self.dob := birthday;
		self.age := if(birthday>0,(integer)ut.getdate[1..4] - (integer)birthday[1..4],0);
		self := l;
		// self := [];
	end;

	header_best := join(Oldest_LNames, watchdog,
		left.did = right.did,
		addBestLast(left, right), left outer, keep(1), local);


	// join to header.File_Relatives to find relatives
	layout_relatives addRelativeLeft(header_best l, fRelatives r) := transform		
		self.lname1 := l.best_lname;
		self.prim_range1 := l.best_prim_range;
		self := r;
		self := l;
		self := [];
	end;

	relatives_left_pre := join(header_best, fRelatives,
		left.did = right.person1 and
		right.prim_range <> -2 and	//remove associates 
		right.prim_range >= -7 and	//remove odd negative values
		right.recent_cohabit <> 0,	//remove records with no dates
		addRelativeLeft(left, right), left outer, keep(100), local);
	// output(relatives_left, named('relatives_left'));


	//fill out relative info on the right
	relatives_left := distribute(relatives_left_pre, person2);
	layout_relatives addRelativeRight(relatives_left l, header_best r) := transform
		self.lname2 := r.best_lname;
		self.prim_range2 := r.best_prim_range;
		self.prim_range := l.prim_range;
		self := r;
		self := l;
		self := [];
	end;

	relatives_right_pre := join(relatives_left, header_best, 
		left.person2 = right.did,
		addRelativeRight(left, right), left outer, keep(100), local);
		
	relatives_right := distribute(relatives_right_pre, person1);
	relatives_full := sort(relatives_right, person1, -recent_cohabit, local);

	marital_status_indicator.Layouts.rFinal_MD_Shell addRelativeSample(header_best l, relatives_full r) := transform
		same_address := if(l.best_prim_range = (string)r.prim_range, true, false);
			self.rel_address 					:= same_address;	
			self.rel_addr_same_lname 	:= if(same_address and r.same_lname, true, false);	
			self.rel_addr_recent_dt 	:= if(same_address, r.recent_cohabit, 0);		
		same_shared_address := if(r.prim_range in [0,-3], true, false);
			self.rel_shared_address 					:= same_shared_address;	
			self.rel_shared_addr_same_lname 	:= if(same_shared_address and r.same_lname, true, false);	
			self.rel_shared_addr_recent_dt 		:= if(same_shared_address, r.recent_cohabit, 0);	
			
		own_vehicle := if(r.prim_range = -6, true, false);
			self.rel_vehicle 					:= own_vehicle;			
		own_property := if(r.prim_range = -5, true, false);
			self.rel_property 				:= own_property;
			self.rel_prop_same_lname 	:= if(own_property and r.same_lname, true, false);
			self.rel_prop_recent_dt 	:= if(own_property, r.recent_cohabit, 0);				
		is_spouse := if(r.prim_range = -7, true, false);
			self.rel_spouse 						:= is_spouse;
			self.rel_spouse_recent_dt 	:= if(is_spouse, r.recent_cohabit, 0);	
			self.rel_spouse_same_lname 	:= if(is_spouse and r.same_lname, true, false);	
		self.prim_range := l.prim_range;
		self := r;
		self := l;
		self := [];
	end;

	relatives_final := join(header_best, relatives_full,
		left.did = right.person1,
		addRelativeSample(left, right), left outer, keep(100), local);


	marital_status_indicator.Layouts.rFinal_MD_Shell relativesRoll(marital_status_indicator.Layouts.rFinal_MD_Shell l, marital_status_indicator.Layouts.rFinal_MD_Shell r) := transform
		same_address := if(l.rel_address, true, false);
			self.rel_address 					:= if(same_address, l.rel_address, r.rel_address);	
			self.rel_addr_same_lname 	:= if(same_address, l.rel_addr_same_lname, r.rel_addr_same_lname);	
			self.rel_addr_recent_dt 	:= if(same_address, l.rel_addr_recent_dt, r.rel_addr_recent_dt);	
		same_shared_address := if(l.rel_shared_address, true, false);
			self.rel_shared_address 					:= if(same_shared_address, l.rel_shared_address, r.rel_shared_address);	
			self.rel_shared_addr_same_lname 	:= if(same_shared_address, l.rel_shared_addr_same_lname, r.rel_shared_addr_same_lname);	
			self.rel_shared_addr_recent_dt 		:= if(same_shared_address, l.rel_shared_addr_recent_dt, r.rel_shared_addr_recent_dt);	
		own_vehicle := if(l.rel_vehicle, true, false);
			self.rel_vehicle 					:= if(own_vehicle, l.rel_vehicle, r.rel_vehicle);	
		own_property := if(l.rel_property, true, false);
			self.rel_prop_same_lname 	:= if(own_property, l.rel_prop_same_lname, r.rel_prop_same_lname);
			self.rel_prop_recent_dt 	:= if(own_property, l.rel_prop_recent_dt, r.rel_prop_recent_dt);	
		is_spouse := if(l.rel_spouse, true, false);
			self.rel_spouse 						:= if(is_spouse, l.rel_spouse, r.rel_spouse);	
			self.rel_spouse_recent_dt 	:= if(is_spouse, l.rel_spouse_recent_dt, r.rel_spouse_recent_dt);
		self := l;
		self := [];
	end;
	rel_roll := rollup(relatives_final, relativesRoll(left,right), did, local);

//get record ids
	marital_status_indicator.Layouts.rFinal_MD_Shell getMDRecID(rel_roll l, pkMD_did r) := transform
		self.record_id := r.record_id;
		self := l;
	end;

	RecID := join(rel_roll, pkMD_did,
					left.did = right.did,
					getMDRecID(left,right), left outer, keep(1), local);
					
	dRecID := distribute(RecID, record_id);
	marital_status_indicator.Layouts.rFinal_MD_Shell getMDDates(dRecID l, pkMD_main r) := transform
		self.div_dt := if(r.divorce_dt = '', (integer)r.divorce_filing_dt, (integer)r.divorce_dt);
		self.mar_dt := if(r.marriage_dt = '', (integer)r.marriage_filing_dt, (integer)r.marriage_dt);
		self := l;
	end;
	mdDates := join(dRecID, pkMD_main,
					left.record_id = right.record_id,
					getMDDates(left,right), left outer, keep(1), local);
	
	
	//get hhid dids
	mdDatesHHID := distribute(mdDates, hhid);
	rHHID getHHIDDids(mdDatesHHID l, households r) := transform
		self.did := l.did;
		self.hhid_did := r.did;
		self := [];
	end;
	HHID_Dids := join(mdDatesHHID, households,
					left.did <> right.did and
					left.hhid = right.hhid_relat,
					getHHIDDids(left,right), left outer, keep(5), local);


	//append best data to dids in HHID
	dHHID_Dids := distribute(HHID_Dids, hhid_did);
	rHHID addBestHHIDData(dHHID_Dids l, watchdog r) := transform
		self.did := l.did;
		self.hhid_did := l.hhid_did;
		self.hhid_did_gender := if(r.title <> '', if(r.title = 'MR', 'M', 'F'),'U');
		self.hhid_did_dob := r.dob;
	end;

	HHID_best := join(dHHID_Dids, watchdog,
		left.hhid_did = right.did,
		addBestHHIDData(left, right), left outer, keep(1), local);
	
	
	//denorm
	mdDatesDID := distribute(mdDates, did);
	dHHID_best := distribute(HHID_best, did);
	marital_status_indicator.Layouts.rFinal_MD_Shell denormHHID(mdDatesDID l, dHHID_best r, integer c ):= transform
		self.hhid_did1 				:= if(c=1, r.hhid_did, 			 l.hhid_did1);
		self.hhid_did1_gender := if(c=1, r.hhid_did_gender, l.hhid_did1_gender);
		self.hhid_did1_dob 		:= if(c=1, r.hhid_did_dob,    l.hhid_did1_dob);
		self.hhid_did2				:= if(c=2, r.hhid_did, 			 l.hhid_did2);
		self.hhid_did2_gender	:= if(c=2, r.hhid_did_gender, l.hhid_did2_gender);
		self.hhid_did2_dob		:= if(c=2, r.hhid_did_dob,    l.hhid_did2_dob);
		self.hhid_did3				:= if(c=3, r.hhid_did, 			 l.hhid_did3);
		self.hhid_did3_gender	:= if(c=3, r.hhid_did_gender, l.hhid_did3_gender);
		self.hhid_did3_dob		:= if(c=3, r.hhid_did_dob,    l.hhid_did3_dob);
		self.hhid_did4				:= if(c=4, r.hhid_did, 			 l.hhid_did4);
		self.hhid_did4_gender	:= if(c=4, r.hhid_did_gender, l.hhid_did4_gender);
		self.hhid_did4_dob		:= if(c=4, r.hhid_did_dob,    l.hhid_did4_dob);
		self.hhid_did5				:= if(c=5, r.hhid_did, 			 l.hhid_did5);
		self.hhid_did5_gender	:= if(c=5, r.hhid_did_gender, l.hhid_did5_gender);
		self.hhid_did5_dob		:= if(c=5, r.hhid_did_dob,    l.hhid_did5_dob);
		self.hhid_cnt 				:= if(r.hhid_did = 0, c, c + 1);
		self := l;
	end;

	HHID_final := DENORMALIZE(mdDatesDID, dHHID_best, 
							left.did = right.did,
							denormHHID(LEFT,RIGHT,COUNTER), local);

	//get MDV1 indicator
	Marital_Status_Indicator.layouts.rFinal_MD_Shell appendMDV1(HHID_final l, MDV1 r) := transform
		self.did := l.did;
		self.marital_status_v1 := r.marital_status;
		self := l;
	end;

	w_MDV1 := join(HHID_final, MDV1,
								left.did = right.did,
								appendMDV1(left, right), LEFT OUTER, KEEP(1), local);
	
	//get bankruptcy data
	Marital_Status_Indicator.layouts.rFinal_MD_Shell get_bk(w_MDV1 l, bankruptcy r) := transform
		self.bankrupt := r.bankrupt;
		self.filing_count := r.filing_count;
		self.bk_recent_count := r.bk_recent_count;
		self.bk_flag := if(r.bankrupt = true or (r.filing_count > 0 or r.bk_recent_count > 0), true, false);
		self := l;
	end;
	
	w_bk := JOIN (w_MDV1, bankruptcy,
                left.did = right.did,
                get_bk(LEFT,RIGHT), left outer, KEEP(1), local);
	
	//get leins data
	Marital_Status_Indicator.layouts.rFinal_MD_Shell get_lien(w_bk l, liens r) := transform
	self.liens_recent_unreleased_count := r.liens_recent_unreleased_count ;
	self := l;
	end;
	
	w_lien := JOIN(w_bk, liens,
								LEFT.did=RIGHT.did,
								get_lien(LEFT,RIGHT), LEFT OUTER, KEEP(1), local);

	//get property data
	Marital_Status_Indicator.layouts.rFinal_MD_Shell get_property(w_lien l, property r) := transform
	self.CurrentPropertyOwner_Flag := if(r.ln_fares_id <> '', true, false);
	self := l;
	end;
	
	w_property := JOIN(w_lien, property,
								LEFT.did=RIGHT.s_did and
								right.source_code = 'OP' and
								left.prim_range = right.prim_range and
								left.prim_name = right.prim_name and
								left.sec_range = right.sec_range,
								get_property(LEFT,RIGHT), LEFT OUTER, KEEP(1), local);

return w_property;

END;
