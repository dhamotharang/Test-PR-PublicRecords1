import address,header,watchdog,ut,doxie, SSNIssue2, doxie_build, BankruptcyV2, header_quick, mdr;

// 4 different versions based upon the source passed in, EQ, EN, TN
// ALL is the combined bureaus

export SSN_table5(dataset(header.layout_header) filtered_header, string version='ALL', boolean isFCRA=false) := function

sysdate := ut.getDate;

lname_var := RECORD
	string20	fname;
	STRING20  lname;
	unsigned3 first_seen;
	unsigned3 last_seen;
END;

common_rec := RECORD
	STRING9 ssn;//
	unsigned3 header_first_seen;//
	unsigned3 header_last_seen;//
	INTEGER headerCount;//
	INTEGER EqCount;//
	INTEGER EnCount;
	INTEGER TnCount;//
	INTEGER TuCount;//
	INTEGER SrcCount;//
	INTEGER DidCount;//
	INTEGER DidCount_c6;//  number of dids created in the last 6 months
	integer addr_ct;  // number of addresses associated with that SSN
	integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months
	INTEGER BestCount;//
	INTEGER RecentCount;  // has a DID that's been seen within the past 18 months	
	unsigned6 BestDid;
	lname_var lname1;
	lname_var lname2;
	lname_var lname3;
	lname_var lname4;
		
	boolean isDeceased;
	unsigned dt_first_deceased;
	unsigned decs_dob;
	string5 decs_zip_lastres;
	string5 decs_zip_lastpayment;
	string20 decs_last;
	string20 decs_first;
	unsigned6 deathDid := 0;
END;

//Get All SSN's

hf := distribute(filtered_header, hash((string9)ssn));

slim :=
RECORD
	hf.did;
	hf.ssn;
	dt_first_seen := MIN(GROUP,IF(hf.dt_first_seen=0,999999,hf.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf.dt_last_seen);
	cnt := COUNT(GROUP);
END;
h_ssn_did := TABLE(hf, slim, ssn, did, LOCAL);

slim_did_plus_deceased := record
	h_ssn_did;
	boolean deceased_did := false;
end;

// determine how much of the death master to use based on source passed in
valid_death_sources := 
map(
isFCRA => ['DE'],
VERSION='EN' => ['DE','EN'],
VERSION='TN' => ['DE','TN'],
VERSION='EQ' => ['DE'],  // equifax can see only SSA death records
['DE','EN','TN'] // COMBO GETS ALL 3
);

deathmasterfile := header.File_DID_Death_MasterV3((LENGTH(TRIM(ssn))=9) AND TRIM(SRC) in valid_death_sources);

// check that the DIDs associated with the ssn aren't deceased
h_ssn_did_wdec := join(distribute(h_ssn_did(did<>0), hash(did)),
													 distribute(deathmasterfile((unsigned)did<>0),hash((unsigned6)did)), 
													 LEFT.did = (unsigned6) RIGHT.did,
													 transform(slim_did_plus_deceased,
																	self.deceased_did := (unsigned)right.did<>0;
																	self := left),
														left outer, keep(1), local);

did_0_added_back := ungroup(h_ssn_did_wdec + project(h_ssn_did(did=0), transform(slim_did_plus_deceased, self := left) ) );

h_ssn_did_plus := distribute(did_0_added_back, hash((string9)ssn));

slim_ssn :=RECORD
	h_ssn_did_plus.ssn;
	dt_first_seen := MIN(GROUP,h_ssn_did_plus.dt_first_seen);
	dt_last_seen := MAX(GROUP,h_ssn_did_plus.dt_last_seen);
	cnt := COUNT(GROUP);
	cnt_c6 := count(group, ut.DaysApart(sysdate[1..6] + '31', h_ssn_did_plus.dt_first_seen[1..6]+'31') < 183); 
	cnt_s18 := count(group, ut.DaysApart(sysdate[1..6] + '31', h_ssn_did_plus.dt_last_seen[1..6]+'31') < risk_indicators.iid_constants.eighteenmonths
													and not h_ssn_did_plus.deceased_did);
	cnt_all := SUM(GROUP,h_ssn_did_plus.cnt);
END;
h_ssn := TABLE(h_ssn_did_plus, slim_ssn, ssn, LOCAL);

common_rec reform(h_ssn le) := TRANSFORM
	SELF.ssn := le.ssn;
	SELF.header_first_seen := IF(le.dt_first_seen=999999,0,le.dt_first_seen);
	SELF.header_last_seen := le.dt_last_seen;
	SELF.DidCount := le.cnt;
	self.DidCount_c6 := le.cnt_c6;
	self.RecentCount := le.cnt_s18;
	SELF.headerCount := le.cnt_all;
	SELF := [];
END;
ssn_start := PROJECT(h_ssn, reform(LEFT));


// get the source counts per ssn
slim_src := RECORD
	hf.ssn;
	hf.src;
	cnt := COUNT(GROUP);
END;

h_ssn_src := TABLE(hf, slim_src, src, ssn, LOCAL);
h_src := TABLE(h_ssn_src, {h_ssn_src.ssn; integer cnt := COUNT(GROUP)}, ssn, LOCAL);


common_rec getCredit(common_rec le, h_ssn_src ri, string src) := TRANSFORM
	SELF.ssn := le.ssn;
	SELF.header_first_seen := le.header_first_seen;
	SELF.header_last_seen := le.header_last_seen;
	SELF.EqCount := IF(trim(src)='EQ', ri.cnt, le.EqCount);
	SELF.EnCount := IF(trim(src)='EN', ri.cnt, le.EnCount);
	SELF.TuCount := IF(trim(src)='TU', ri.cnt, le.TuCount);
	self.TnCount := IF(trim(src)='TN', ri.cnt, le.TNCount);
	SELF := le;
END;

with_eq := JOIN(ssn_start, h_ssn_src(trim(src)='EQ'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT, 'EQ'), LEFT OUTER, LOCAL);
with_tu := JOIN(with_eq, h_ssn_src(trim(src)='TU'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT,'TU'), LEFT OUTER, LOCAL);
with_tn := JOIN(with_tu, h_ssn_src(trim(src)='TN'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT,'TN'), LEFT OUTER, LOCAL);
with_en := JOIN(with_tn, h_ssn_src(trim(src)='EN'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT, 'EN'), LEFT OUTER, LOCAL);


// get all of the name variations per ssn, and the dates they were first seen on 
ssn_var_rec := RECORD
	hf.ssn;
	hf.fname;
	hf.lname;
	last_seen := MAX(GROUP,hf.dt_last_seen);
	first_seen := MIN(GROUP,IF(hf.dt_first_seen=0,999999,hf.dt_first_seen));
END;

// if the version to build is EN, use EN source to get the last names and dates
// if it's EQ, use just EQ to get the last names and dates, otherwise use both of them
source_set := map(version = 'EQ' => ['EQ'],
									version = 'EN' => ['EN'],
									version = 'TN' => ['TN'],
									version = 'ALL' => ['EQ','EN','TN'],
									['EQ']);

header_for_names := hf(trim(src) in source_set and ut.DaysApart((STRING6)dt_last_seen+'31',sysdate)<30*18);
ssn_var := TABLE(header_for_names,ssn_var_rec,ssn,lname,fname,LOCAL);

							 
ssn_var_rec roll_dates(ssn_var_rec le, ssn_var_rec ri) :=
TRANSFORM
	SELF.last_seen := ut.max2(le.last_seen,ri.last_seen);
	SELF.first_seen := ut.min2(le.first_seen,ri.first_seen);
	// rollup to longest fname....avoids initials, abbrev, and nicknames.
	self.fname := if (length(trim(Le.fname))>=length(trim(Ri.fname)), Le.fname, Ri.fname);
	SELF := le;
END;

ssn_var_sorted := SORT(ssn_var,ssn,lname,LOCAL);
ssn_var_roll := ROLLUP(ssn_var_sorted,
					LEFT.ssn=RIGHT.ssn AND
					LEFT.lname=RIGHT.lname,
				roll_dates(LEFT,RIGHT), local)(first_seen!=999999);

bestfile := map(		version='EN' => watchdog.File_Best_nonEquifax,  
										version='EQ' => watchdog.File_Best_nonExperian,
										watchdog.file_best);

best_distr := DISTRIBUTE(bestfile(length(trim(ssn))=9),HASH((string9)ssn));
								
ssn_var_roll_checked := JOIN(ssn_var_roll,
															best_distr,
															LEFT.ssn=RIGHT.ssn,
					TRANSFORM(recordof(ssn_var_roll), 
										self.lname := if(trim(left.lname)=trim(right.lname), left.lname, skip),
										SELF := LEFT), 
										KEEP(1), LOCAL);

// keep up to 4 name variations per ssn
ssn_var4 := DEDUP(SORT(ssn_var_roll_checked,ssn,-last_seen,first_seen,LOCAL),ssn,KEEP(4),LOCAL);

common_rec getVars(common_rec le, ssn_var4 ri, INTEGER c) := TRANSFORM
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

with_vars := DENORMALIZE(with_en,ssn_var4,LEFT.ssn=RIGHT.ssn, getVars(LEFT,RIGHT,COUNTER), LEFT OUTER, LOCAL);

common_rec getSrcCount(common_rec le, h_src ri) := TRANSFORM
	SELF.SrcCount := ri.cnt;
	SELF := le;
END;

with_src := JOIN(with_vars, h_src, LEFT.ssn=RIGHT.ssn, getSrcCount(LEFT,RIGHT), LEFT OUTER, LOCAL) ;

// number of DIDs with the SSN as best
w := best_distr;

w_cnt_rec := RECORD
	w.ssn;
	cnt := COUNT(GROUP);
END;
w_cnt := TABLE(w, w_cnt_rec, ssn, LOCAL);

common_rec get_wssn_cnt(common_rec le, w_cnt_rec ri) := TRANSFORM
	SELF.BestCount := ri.cnt;
	SELF := le;
END;

with_bestcnt := JOIN(with_src, w_cnt, LEFT.ssn=RIGHT.ssn, get_wssn_cnt(LEFT,RIGHT), LEFT OUTER, LOCAL);

// If there is 1, get best DID
common_rec getBest(common_rec le, bestfile ri) := TRANSFORM
	SELF.BestDid := ri.did;
	SELF := le;
END;
with_best := JOIN(with_bestcnt, w, LEFT.ssn=RIGHT.ssn AND LEFT.BestCount=1, 
					getBest(LEFT,RIGHT), LEFT OUTER, LOCAL);


// append addr counts per ssn
addr_slim := RECORD
	hf.ssn;
	addr1 := trim(hf.zip) + trim(hf.prim_name) + trim(hf.prim_range);
	dt_first_seen := MIN(GROUP,IF(hf.dt_first_seen=0,999999,hf.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf.dt_last_seen);
	// cnt := COUNT(GROUP);
END;
d_addr := TABLE(hf(TRIM(zip)<>'' and trim(prim_name)<>'' and trim(prim_range)<>''), addr_slim, 
								ssn, zip, prim_name, prim_range, LOCAL);

addr_stats := record
	ssn := d_addr.ssn;
	addr_ct := count(group);
	addr_ct_c6 := count(group, ut.DaysApart(sysdate[1..6]+'31', d_addr.dt_first_seen[1..6]+'31') < 183);
end;
addr_counts := table(d_addr, addr_stats, ssn, local);

persist_name := map(version='TN' and isFCRA => 'persist::ssn_table5_tn_fcra',
										version='TN' => 'persist::ssn_table5_tn',
										version='EN' and isFCRA => 'persist::ssn_table5_en_fcra',
										version='EN' => 'persist::ssn_table5_en',
										version='EQ' and isFCRA => 'persist::ssn_table5_eq_fcra',
										version='EQ' => 'persist::ssn_table5_eq',
										version='ALL' and isFCRA => 'persist::ssn_table5_all_fcra',
										'persist::ssn_table5_all');
										
addrs_per_ssn := join(with_best, 
											addr_counts, left.ssn=right.ssn, 
				transform(common_rec, self.addr_ct := right.addr_ct, self.addr_ct_c6 := right.addr_ct_c6, self := left), 
				left outer, local);
				
				
				
// use the v3 file, but only use the Death master records.  TN and EN death reside in the source permitted sections
dm := distribute(deathmasterfile, hash(ssn));

// sort by src ascending so that DE records are selected over EN and TN records
// sort by fname descending to select a record with a full name as opposed to a possible record with just an initial
death_master_deduped := dedup( sort(dm, ssn, src, -fname, -dod8, -dob8, local), ssn, local);

common_rec getDead(common_rec le, death_master_deduped ri) :=
TRANSFORM
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
				// LEFT.ssn=RIGHT.ssn, getDead(LEFT,RIGHT), FULL OUTER, LOCAL) : persist(persist_name, expire(30));
				LEFT.ssn=RIGHT.ssn, getDead(LEFT,RIGHT), FULL OUTER, LOCAL);

return with_dead;


end;