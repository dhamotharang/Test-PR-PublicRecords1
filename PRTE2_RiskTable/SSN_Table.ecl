import header, watchdog, ut, STD, risk_indicators, prte2_death_master, prte2_watchdog, prte2_header;

export SSN_Table(dataset(header.layout_header) filtered_header, string version='ALL', boolean isFCRA=false) := function

	sysdate := (string) risk_indicators.iid_constants.todaydate;
	slim := RECORD
		filtered_header.did;
		filtered_header.ssn;
		dt_first_seen := MIN(GROUP,IF(filtered_header.dt_first_seen=0,999999,filtered_header.dt_first_seen));
		dt_last_seen := MAX(GROUP,filtered_header.dt_last_seen);
		cnt := COUNT(GROUP);
	END;
	h_ssn_did := TABLE(filtered_header, slim, ssn, did);
	slim_did_plus_deceased := record
		h_ssn_did;
		boolean deceased_did := false;
	end;
	valid_death_sources := map(	isFCRA => ['DE'],
							VERSION='EN' => ['DE','EN'],
							VERSION='TN' => ['DE','TN'],
							VERSION='EQ' => ['DE'],  // equifax can see only SSA death records
							['DE','EN','TN'] // COMBO GETS ALL 3
						);
	deathmasterfile := prte2_death_master.Files.File_DeathMaster_Building((LENGTH(TRIM(ssn))=9) AND TRIM(SRC) in valid_death_sources);
	h_ssn_did_wdec := join(	h_ssn_did(did<>0),
						deathmasterfile((unsigned)did<>0), 
						LEFT.did = (unsigned6) RIGHT.did,
						transform(slim_did_plus_deceased,
									self.deceased_did := (unsigned)right.did<>0;
									self := left),
						left outer, keep(1));
	did_0_added_back := ungroup(h_ssn_did_wdec + project(h_ssn_did(did=0), transform(slim_did_plus_deceased, self := left) ) );
	
	slim_ssn :=RECORD
		did_0_added_back.ssn;
		dt_first_seen := MIN(GROUP,did_0_added_back.dt_first_seen);
		dt_last_seen := MAX(GROUP,did_0_added_back.dt_last_seen);
		cnt := COUNT(GROUP);
		cnt_c6 := count(group, ut.DaysApart(sysdate[1..6] + '31', ((string)did_0_added_back.dt_first_seen)[1..6]+'31') < 183); 
		cnt_s18 := count(group, ut.DaysApart(sysdate[1..6] + '31', ((string)did_0_added_back.dt_last_seen)[1..6]+'31') < risk_indicators.iid_constants.eighteenmonths
														and not did_0_added_back.deceased_did);
		cnt_all := SUM(GROUP,did_0_added_back.cnt);
		cnt_multiple_use := count(group, did_0_added_back.cnt>1);
	END;
	h_ssn := TABLE(did_0_added_back, slim_ssn, ssn);

	Layouts.common_rec_v4_2 reform(h_ssn le) := TRANSFORM
		SELF.ssn := le.ssn;
		SELF.header_first_seen := IF(le.dt_first_seen=999999,0,le.dt_first_seen);
		SELF.header_last_seen := le.dt_last_seen;
		SELF.DidCount := le.cnt;
		self.DidCount_c6 := le.cnt_c6;
		self.didcount_multiple_use := le.cnt_multiple_use;
		self.RecentCount := le.cnt_s18;
		SELF.headerCount := le.cnt_all;
		SELF := [];
	END;
	ssn_start := PROJECT(h_ssn, reform(LEFT));
	slim_src := RECORD
		filtered_header.ssn;
		filtered_header.src;
		cnt := COUNT(GROUP);
	END;
	h_ssn_src := TABLE(filtered_header, slim_src, src, ssn);
	h_src := TABLE(h_ssn_src, {h_ssn_src.ssn; integer cnt := COUNT(GROUP)}, ssn);
	Layouts.common_rec_v4_2 getCredit(Layouts.common_rec_v4_2 le, h_ssn_src ri, string src) := TRANSFORM
		SELF.ssn := le.ssn;
		SELF.header_first_seen := le.header_first_seen;
		SELF.header_last_seen := le.header_last_seen;
		SELF.EqCount := IF(trim(src)='EQ', ri.cnt, le.EqCount);
		SELF.EnCount := IF(trim(src)='EN', ri.cnt, le.EnCount);
		SELF.TuCount := IF(trim(src)='TU', ri.cnt, le.TuCount);
		self.TnCount := IF(trim(src)='TN', ri.cnt, le.TNCount);
		SELF := le;
	END;
	with_eq := JOIN(ssn_start, h_ssn_src(trim(src)='EQ'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT, 'EQ'), LEFT OUTER);
	with_tu := JOIN(with_eq, h_ssn_src(trim(src)='TU'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT,'TU'), LEFT OUTER);
	with_tn := JOIN(with_tu, h_ssn_src(trim(src)='TN'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT,'TN'), LEFT OUTER);
	with_en := JOIN(with_tn, h_ssn_src(trim(src)='EN'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT, 'EN'), LEFT OUTER);
	ssn_var_rec := RECORD
		filtered_header.ssn;
		filtered_header.fname;
		filtered_header.lname;
		last_seen := MAX(GROUP,filtered_header.dt_last_seen);
		first_seen := MIN(GROUP,IF(filtered_header.dt_first_seen=0,999999,filtered_header.dt_first_seen));
	END;
	source_set := map(version = 'EQ' => ['EQ'],
										version = 'EN' => ['EN'],
										version = 'TN' => ['TN'],
										version = 'ALL' => ['EQ','EN','TN'],
										['EQ']);

	header_for_names := filtered_header(trim(src) in source_set and ut.DaysApart((STRING6)dt_last_seen+'31',sysdate)<30*18);
	ssn_var := TABLE(header_for_names,ssn_var_rec,ssn,lname,fname);							 
	ssn_var_rec roll_dates(ssn_var_rec le, ssn_var_rec ri) :=
	TRANSFORM
		SELF.last_seen := MAX(le.last_seen,ri.last_seen);
		SELF.first_seen := ut.min2(le.first_seen,ri.first_seen);
		// rollup to longest fname....avoids initials, abbrev, and nicknames.
		self.fname := if (length(trim(Le.fname))>=length(trim(Ri.fname)), Le.fname, Ri.fname);
		SELF := le;
	END;
	ssn_var_sorted := SORT(ssn_var,ssn,lname);
	ssn_var_roll := ROLLUP(ssn_var_sorted,
						LEFT.ssn=RIGHT.ssn AND
						LEFT.lname=RIGHT.lname,
					roll_dates(LEFT,RIGHT))(first_seen!=999999);
	bestfile := 	prte2_watchdog.Files.file_best;
	best_distr := bestfile(length(trim(ssn))=9);						
	ssn_var_roll_checked := JOIN(	ssn_var_roll,
							best_distr,
							LEFT.ssn=RIGHT.ssn,
							TRANSFORM(recordof(ssn_var_roll), 
								self.lname := if(trim(left.lname)=trim(right.lname), left.lname, skip),
								SELF := LEFT), 
							KEEP(1));
	ssn_var4 := DEDUP(SORT(ssn_var_roll_checked,ssn,-last_seen,first_seen),ssn,KEEP(4));
	Layouts.common_rec_v4_2 getVars(Layouts.common_rec_v4_2 le, ssn_var4 ri, INTEGER c) := TRANSFORM
		self.lname1.fname := if (c=1, ri.fname, le.lname1.fname);
		SELF.lname1.lname := IF(c=1,ri.lname,le.lname1.lname);
		SELF.lname1.last_seen := IF(c=1,ri.last_seen,le.lname1.last_seen);
		SELF.lname1.first_seen := IF(c=1,ri.first_seen,le.lname1.first_seen);
		self.lname2.fname := if (c=2, ri.fname, le.lname2.fname);
		SELF.lname2.lname := IF(c=2,ri.lname,le.lname2.lname);
		SELF.lname2.last_seen := IF(c=2,ri.last_seen,le.lname2.last_seen);
		SELF.lname2.first_seen := IF(c=2,ri.first_seen,le.lname2.first_seen);
		self.lname3.fname := if (c=3, ri.fname, le.lname3.fname);
		SELF.lname3.lname := IF(c=3,ri.lname,le.lname3.lname);
		SELF.lname3.last_seen := IF(c=3,ri.last_seen,le.lname3.last_seen);
		SELF.lname3.first_seen := IF(c=3,ri.first_seen,le.lname3.first_seen);	
		self.lname4.fname := if(c=4,ri.fname, le.lname4.fname);
		SELF.lname4.lname := IF(c=4,ri.lname,le.lname4.lname);
		SELF.lname4.last_seen := IF(c=4,ri.last_seen,le.lname4.last_seen);
		SELF.lname4.first_seen := IF(c=4,ri.first_seen,le.lname4.first_seen);
		SELF := le;
	END;

	with_vars := DENORMALIZE(with_en,ssn_var4,LEFT.ssn=RIGHT.ssn, getVars(LEFT,RIGHT,COUNTER), LEFT OUTER);

	ssn_unique_last_names := TABLE(	header_for_names,
								{ssn, lname, last_seen := MAX(GROUP,dt_last_seen),first_seen := MIN(GROUP,IF(dt_first_seen=0,999999,dt_first_seen))}, 
								ssn,lname);

	lname_counts := table(	ssn_unique_last_names, 
						{ssn, lname_ct := count(group),lname_ct_c6 := count(group, ut.DaysApart(sysdate[1..6]+'31', ((string)first_seen)[1..6]+'31') < 183)}, 
						ssn);
	with_last_name_stats := join(	with_vars, 
							lname_counts, 
							left.ssn=right.ssn, 
							transform(Layouts.common_rec_v4_2,
								self.lname_ct := right.lname_ct;
								self.lname_ct_c6 := right.lname_ct_c6;
								self := left), 
							left outer);
	Layouts.common_rec_v4_2 getSrcCount(Layouts.common_rec_v4_2 le, h_src ri) := TRANSFORM
		SELF.SrcCount := ri.cnt;
		SELF := le;
	END;
	with_src := JOIN(	with_last_name_stats, 
					h_src, 
					LEFT.ssn=RIGHT.ssn, 
					getSrcCount(LEFT,RIGHT), 
					LEFT OUTER) ;
	w_cnt_rec := RECORD
		best_distr.ssn;
		cnt := COUNT(GROUP);
	END;
	w_cnt := TABLE(best_distr, w_cnt_rec, ssn);
	Layouts.common_rec_v4_2 get_wssn_cnt(Layouts.common_rec_v4_2 le, w_cnt_rec ri) := TRANSFORM
		SELF.BestCount := ri.cnt;
		SELF := le;
	END;
	with_bestcnt := JOIN(	with_src, 
						w_cnt, 
						LEFT.ssn=RIGHT.ssn, 
						get_wssn_cnt(LEFT,RIGHT), 
						LEFT OUTER);
	Layouts.common_rec_v4_2 getBest(Layouts.common_rec_v4_2 le, bestfile ri) := TRANSFORM
		SELF.BestDid := ri.did;
		SELF := le;
	END;
	with_best := JOIN(	with_bestcnt, 
					best_distr, 
					LEFT.ssn=RIGHT.ssn AND LEFT.BestCount=1, 
					getBest(LEFT,RIGHT), 
					LEFT OUTER);
	addr_slim := RECORD
		filtered_header.ssn;
		addr1 := trim(filtered_header.zip) + trim(filtered_header.prim_name) + trim(filtered_header.prim_range);
		dt_first_seen := MIN(GROUP,IF(filtered_header.dt_first_seen=0,999999,filtered_header.dt_first_seen));
		dt_last_seen := MAX(GROUP,filtered_header.dt_last_seen);
		cnt := COUNT(GROUP);
	END;
	d_addr := TABLE(	filtered_header(TRIM(zip)<>'' and trim(prim_name)<>'' and trim(prim_range)<>''), 
					addr_slim, ssn, zip, prim_name, prim_range);
	addr_stats := record
		ssn := d_addr.ssn;
		addr_ct := count(group);
		addr_ct_c6 := count(group, ut.DaysApart(sysdate[1..6]+'31', ((string)d_addr.dt_first_seen)[1..6]+'31') < 183);
		addr_ct_multiple_use := count(group, d_addr.cnt>1);
	end;
	addr_counts := table(d_addr, addr_stats, ssn);									
	addrs_per_ssn := join(	with_best, 
						addr_counts, 
						left.ssn=right.ssn, 
						transform(Layouts.common_rec_v4_2, 
							self.addr_ct := right.addr_ct, self.addr_ct_c6 := right.addr_ct_c6, 
							self.addr_ct_multiple_use := right.addr_ct_multiple_use, self := left), 
						left outer);
	dFileHeader				:=	PRTE2_Header.Files.file_headers;
	dDeathMaster_Dist	:=	SORT(deathmasterfile((UNSIGNED)did>0 AND ssn<>''),(UNSIGNED)did,ssn);
	dFileHeader_Dist	:=	DEDUP(SORT(dFileHeader((UNSIGNED)did>0 AND ssn<>''),(UNSIGNED)did,ssn),(UNSIGNED)did,ssn);
	Valid_SSN_Layout	:=	RECORD
		STRING1	valid_SSN	:=	'';
		RECORDOF(deathmasterfile);
	END;
	dDMValidSSN	:=	JOIN(dDeathMaster_DIST,
						dFileHeader_Dist,
						(UNSIGNED)LEFT.did	=	(UNSIGNED)RIGHT.did	AND
						LEFT.ssn						=	RIGHT.ssn,
						TRANSFORM(Valid_SSN_Layout,SELF.valid_SSN:=RIGHT.valid_SSN,SELF:=LEFT),
						LEFT OUTER
					);
	BadSSNTypes						:=	['F','B','Z'];	// 
	deathmasterfile_FCRA	:=	dDMValidSSN(valid_SSN NOT IN BadSSNTypes);
	dm	:=	IF(	isFCRA,
				PROJECT(deathmasterfile_FCRA,TRANSFORM(RECORDOF(deathmasterfile),SELF:=LEFT)),
				deathmasterfile);
	death_master_deduped := dedup( sort(dm, ssn, src, -fname, -dod8, -dob8), ssn);
	Layouts.common_rec_v4_2 getDead(Layouts.common_rec_v4_2 le, death_master_deduped ri) :=TRANSFORM
		death_only := le.ssn='';
		SELF.ssn := if(death_only, ri.ssn, le.ssn);  // ssn only exists on death master file
		SELF.isDeceased := ri.ssn<>'';
		SELF.dt_first_deceased := IF(ri.ssn<>'', (unsigned)ri.dod8,0);
		self.decs_dob := IF(ri.ssn<>'', (unsigned)ri.dob8,0);
		self.decs_zip_lastres := IF(ri.ssn<>'', ri.zip_lastres, '');
		self.decs_zip_lastpayment := IF(ri.ssn<>'', ri.zip_lastpayment, '');
		self.decs_last := IF(ri.ssn<>'', ri.lname, '');
		self.decs_first := IF(ri.ssn<>'', ri.fname, '');
		self.deathdid := (unsigned)ri.did;	
		SELF := le;
	END;
	with_dead := JOIN(addrs_per_ssn, death_master_deduped,
					LEFT.ssn=RIGHT.ssn, getDead(LEFT,RIGHT), FULL OUTER);
	return with_dead;

end;