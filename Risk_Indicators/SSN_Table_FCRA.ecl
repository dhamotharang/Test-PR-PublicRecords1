import address,bankrupt,header,watchdog,ut,doxie, fcra, SSNIssue2, doxie_build;

lname_var :=
RECORD
	string20	fname;
	STRING20  lname;
	unsigned3 first_seen;
	unsigned3 last_seen;
END;

rec :=
RECORD
	STRING9 ssn;//
	unsigned3 official_first_seen;
	unsigned3 official_last_seen;
	unsigned3 header_first_seen;//
	unsigned3 header_last_seen;//
	boolean isValidFormat;
	boolean isSequenceValid;
	boolean isBankrupt;//
	unsigned dt_first_bankrupt;	
	boolean isDeceased;//
	unsigned dt_first_deceased;
	unsigned decs_dob;
	string5 decs_zip_lastres;
	string5 decs_zip_lastpayment;
	string20 decs_last;
	string20 decs_first;
	STRING2 issue_state;
	INTEGER headerCount;//
	INTEGER EqCount;//
	INTEGER TuCount;//
	INTEGER SrcCount;//
	INTEGER DidCount;//
	INTEGER BestCount;//
	INTEGER RecentCount;
	unsigned6 BestDid;//
	lname_var lname1;
	lname_var lname2;
	lname_var lname3;
	lname_var lname4;
END;

// Get All SSN's
h := DISTRIBUTE(header.File_Headers(LENGTH(TRIM(ssn))=9, ~fcra.Restricted_Header_Src(src, vendor_id[1])), HASH((STRING9)ssn));

ssn_var_rec :=
RECORD
	h.ssn;
	h.fname;
	h.lname;
	last_seen := MAX(GROUP,h.dt_last_seen);
	first_seen := MIN(GROUP,IF(h.dt_first_seen=0,999999,h.dt_first_seen));
END;
ssn_var := TABLE(h(src='EQ',ut.DaysApart((STRING6)dt_last_seen+'31',ut.GetDate)<30*18),ssn_var_rec,ssn,lname,fname,LOCAL);
ssn_var_rec roll_dates(ssn_var_rec le, ssn_var_rec ri) :=
TRANSFORM
	SELF.last_seen := ut.max2(le.last_seen,ri.last_seen);
	SELF.first_seen := ut.min2(le.first_seen,ri.first_seen);
	// rollup to longest fname....avoids initials, abbrev, and nicknames.
	self.fname := if (length(trim(Le.fname))>=length(trim(Ri.fname)), Le.fname, Ri.fname);
	SELF := le;
END;
ssn_var_roll := ROLLUP(SORT(ssn_var,ssn,lname,LOCAL),
					LEFT.ssn=RIGHT.ssn AND
					LEFT.lname=RIGHT.lname,
				roll_dates(LEFT,RIGHT),LOCAL)(first_seen!=999999);

ssn_var4 := DEDUP(SORT(ssn_var_roll,ssn,-last_seen,first_seen,LOCAL),ssn,KEEP(4),LOCAL);

slim :=
RECORD
	h.did;
	h.ssn;
	dt_first_seen := MIN(GROUP,IF(h.dt_first_seen=0,999999,h.dt_first_seen));
	dt_last_seen := MAX(GROUP,h.dt_last_seen);
	cnt := COUNT(GROUP);
END;
h_ssn_did := TABLE(h, slim, ssn, did, LOCAL);

slim_src :=
RECORD
	h.ssn;
	h.src;
	cnt := COUNT(GROUP);
END;

h_ssn_src := TABLE(h, slim_src, src, ssn, LOCAL);
h_src := TABLE(h_ssn_src, {h_ssn_src.ssn; integer cnt := COUNT(GROUP)}, ssn, LOCAL);


slim_ssn :=
RECORD
	h_ssn_did.ssn;
	dt_first_seen := MIN(GROUP,h_ssn_did.dt_first_seen);
	dt_last_seen := MAX(GROUP,h_ssn_did.dt_last_seen);
	cnt := COUNT(GROUP);
	cnt_all := SUM(GROUP,h_ssn_did.cnt);
END;
h_ssn := TABLE(h_ssn_did, slim_ssn, ssn, LOCAL);

rec reform(h_ssn le) :=
TRANSFORM
	SELF.ssn := le.ssn;
	SELF.header_first_seen := IF(le.dt_first_seen=999999,0,le.dt_first_seen);
	SELF.header_last_seen := le.dt_last_seen;
	SELF.DidCount := le.cnt;
	SELF.headerCount := le.cnt_all;
	
	vssn := Validate_SSN(le.ssn,'');
	
	SELF.isValidFormat := ~(vssn.invalid OR vssn.begin_invalid OR
					  vssn.middle_invalid OR vssn.last_invalid);
	SELF := [];
END;
ssn_start := PROJECT(h_ssn, reform(LEFT));


rec getCredit(rec le, h_ssn_src ri, string src) :=
TRANSFORM
	SELF.ssn := le.ssn;
	SELF.header_first_seen := le.header_first_seen;
	SELF.header_last_seen := le.header_last_seen;
	SELF.EqCount := IF(src='EQ', ri.cnt, le.EqCount);
	SELF.TuCount := IF(src='TU', ri.cnt, le.TuCount);
	SELF := le;
END;

with_eq := JOIN(ssn_start, h_ssn_src(src='EQ'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT, 'EQ'), LEFT OUTER, LOCAL);
with_tu := JOIN(with_eq, h_ssn_src(src='TU'), LEFT.ssn=RIGHT.ssn, getCredit(LEFT,RIGHT,'TU'), LEFT OUTER, LOCAL);

rec getVars(rec le, ssn_var4 ri, INTEGER c) :=
TRANSFORM
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

with_vars := DENORMALIZE(with_tu,ssn_var4,LEFT.ssn=RIGHT.ssn, getVars(LEFT,RIGHT,COUNTER), LEFT OUTER, LOCAL);

rec getSrcCount(rec le, h_src ri) :=
TRANSFORM
	SELF.SrcCount := ri.cnt;
	SELF := le;
END;
with_src := JOIN(with_vars, h_src, LEFT.ssn=RIGHT.ssn, getSrcCount(LEFT,RIGHT), LEFT OUTER, LOCAL) : persist('persist::ssn_risk_header_FCRA');

// Match Against BK
recx :=
RECORD
	rec;
	string10   seq_number;
	string5    court_code;
	string7    case_number;
END;

//recx getBk(rec le, Bankrupt.File_BK_Search_FCRA ri) :=
recx getBk(rec le, Bankrupt.File_BK_Search ri) :=
TRANSFORM
	SELF.seq_number := ri.seq_number;
	SELF.court_code := ri.court_code;
	SELF.case_number := ri.case_number;
	SELF.isBankrupt := ri.debtor_ssn<>'';
	SELF := le;
END;

//dis_search := distribute(Bankrupt.File_BK_Search_FCRA(LENGTH(TRIM(debtor_ssn))=9),hash(debtor_ssn));
dis_search := distribute(Bankrupt.File_BK_Search (LENGTH(TRIM(debtor_ssn))=9),hash(debtor_ssn));
with_bk := JOIN(with_src,dis_search,
			LEFT.ssn=RIGHT.debtor_ssn, getBk(LEFT,RIGHT), LEFT OUTER, local);

//Must split out records with court code from ones without for next join
bk_code := with_bk(court_code!='');
no_bk_code := project(with_bk(court_code=''),transform(rec,self := left));

//rec getBkDate(recx le, Bankrupt.File_BK_Main_FCRA ri) :=
rec getBkDate(recx le, Bankrupt.File_BK_Main ri) :=
TRANSFORM
	SELF.dt_first_bankrupt := (unsigned)ri.date_filed;
	SELF := le;
END;

//with_bk_date := JOIN(bk_code,Bankrupt.File_BK_Main_FCRA,
with_bk_date := JOIN(bk_code,Bankrupt.File_BK_Main,
			LEFT.seq_number=RIGHT.seq_number AND 
			LEFT.court_code=RIGHT.court_code AND
			LEFT.case_number=RIGHT.case_number, getBkDate(LEFT,RIGHT), LEFT OUTER,hash);

all_again := distribute(with_bk_date + no_bk_code,hash(ssn));

rec getDead(rec le, header.File_Death_Master_Plus ri) :=
TRANSFORM
	SELF.isDeceased := ri.ssn<>'';
	SELF.dt_first_deceased := IF(ri.ssn<>'', (unsigned)ri.dod8,0);
	self.decs_dob := IF(ri.ssn<>'', (unsigned)ri.dob8,0);
	self.decs_zip_lastres := IF(ri.ssn<>'', ri.zip_lastres, '');
	self.decs_zip_lastpayment := IF(ri.ssn<>'', ri.zip_lastpayment, '');
	self.decs_last := IF(ri.ssn<>'', ri.clean_lname, '');
	self.decs_first := IF(ri.ssn<>'', ri.clean_fname, '');
	SELF := le;
END;

with_dead := JOIN(all_again, DISTRIBUTE(header.File_Death_Master_Plus(LENGTH(TRIM(ssn))=9),HASH(ssn)),
				LEFT.ssn=RIGHT.ssn, getDead(LEFT,RIGHT), LEFT OUTER, LOCAL);

// number of DIDs with the SSN as best
best_ssns := watchdog.BestSSNFunc(header.File_Headers(LENGTH(TRIM(ssn))=9 and ~fcra.Restricted_Header_Src(src, vendor_id[1])));

w := DISTRIBUTE(best_ssns,HASH((STRING9)ssn));

w_cnt_rec :=
RECORD
	w.ssn;
	cnt := COUNT(GROUP);
END;
w_cnt := TABLE(w, w_cnt_rec, ssn, LOCAL);

rec get_wssn_cnt(rec le, w_cnt_rec ri) :=
TRANSFORM
	SELF.BestCount := ri.cnt;
	SELF := le;
END;
with_bestcnt := JOIN(with_dead, w_cnt, LEFT.ssn=RIGHT.ssn, get_wssn_cnt(LEFT,RIGHT), LEFT OUTER, LOCAL);

// If there is 1, get best DID
rec getBest(rec le, w ri) :=
TRANSFORM
	SELF.BestDid := ri.did;
	SELF := le;
END;
with_best := JOIN(with_bestcnt, w, LEFT.ssn=RIGHT.ssn AND LEFT.BestCount=1, getBest(LEFT,RIGHT), LEFT OUTER, LOCAL);

// number of DIDs with the SSN that have been recently reported
dsdf := doxie.DID_SSN_Date_FCRA(doxie_build.file_headerprod_building);
recents := JOIN(h_ssn_did, dsdf, LEFT.did = RIGHT.did and LEFT.ssn = RIGHT.ssn,
                TRANSFORM(slim, SELF := LEFT),LEFT ONLY);
recent_cnt_rec :=
RECORD
	recents.ssn;
	cnt := COUNT(GROUP);
END;
recents_cntd := TABLE(recents, recent_cnt_rec, ssn, LOCAL);

rec get_recent_cnt(rec le, recents_cntd ri) :=
TRANSFORM
	SELF.RecentCount := ri.cnt;
	SELF := le;
END;
with_recents := JOIN(with_best, recents_cntd, LEFT.ssn = RIGHT.ssn, get_recent_cnt(LEFT,RIGHT), LEFT OUTER, LOCAL);

// Get info from SSA table
rec get_ssa(rec le, header.Layout_SSN_Map ri) :=
TRANSFORM
	SELF.issue_state := Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state));
	SELF.official_first_seen := (unsigned3) (ri.start_date[1..6]); //YYYYMM

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (Ri.end_date='20990101', '', Ri.end_date[1..6]);
	SELF.official_last_seen  := (unsigned3) r_end; //YYYYMM
	SELF.isSequenceValid := IF(ri.ssn5<>'',true,false);
	SELF := le;
END;

with_ssa := JOIN(with_recents, header.File_SSN_Map, 
                 (LEFT.ssn[1..5]=RIGHT.ssn5) AND
                 (Left.ssn[6..9] between Right.start_serial and Right.end_serial),
                 get_ssa(LEFT,RIGHT), 
                 LEFT OUTER, LOOKUP);

rec pickdates(rec le, rec ri) :=
TRANSFORM
	SELF.dt_first_deceased := ut.Min2(le.dt_first_deceased,ri.dt_first_deceased);
	SELF.dt_first_bankrupt := ut.Min2(le.dt_first_bankrupt,ri.dt_first_bankrupt);
	SELF := le;
END;
ddp := ROLLUP(SORT(with_ssa,ssn,LOCAL),pickdates(LEFT,RIGHT),ssn,LOCAL);

export SSN_Table_FCRA := ddp : PERSIST('persist::ssn2_risk_table_FCRA');