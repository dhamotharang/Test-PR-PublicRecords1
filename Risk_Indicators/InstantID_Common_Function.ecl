import didville,doxie,FCRA,header,header_quick,header_SlimSort,watchdog,ut,DID_Add,address,
       gong,drivers,mdr,riskwise,suppress;

export InstantID_Common_Function(DATASET(Layout_Input) indata, unsigned1 dppa, unsigned1 glb, boolean isUtility=false, 
							boolean ln_branded, unsigned3 history_date=999999, boolean suppressNearDups=false, 
							boolean isFCRA=false, dataset(Layout_Gateways_In) gateways, unsigned1 BSversion=1) :=
FUNCTION

min_numscore := 90;
gn(UNSIGNED1 I) := i BETWEEN min_numscore AND 100;
tscore(UNSIGNED1 i) := IF(i=255,0,i);

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12 or isFCRA;
dppa_ok := dppa > 0 and dppa < 8 or isFCRA;
fz := '4GZ';
dedup_these := true;
allscores := false;
appends := 'BEST_DOB';
verify := 'BEST_DOB';
thresh_num := 0;

full_history_date := (STRING8)((STRING6)history_date+'01');
myGetDate := IF(history_date=999999,ut.GetDate,full_history_date);
myDaysApart(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= 365 OR (unsigned)d2 >= (unsigned)full_history_date;

didprep := PROJECT(indata, TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));

didville.MAC_DidAppend(didprep,resu,dedup_these,fz,allscores)

dwelltype(STRING1 at) := MAP(at='F' => '',	// changed to blank from B on 6/16/05, F seems to mean an invalid address
					    at='G' => 'S',
					    at='H' => 'A',
					    at='P' => 'E',
					    at='R' => 'R',
					    at='S' => ' ',  // this may be incorrect, it could be a G
					    '');
					  		
invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420','E421','E423','E500','E501','E502','E503','E600'];	// added E600 6/6/2005 per Jim C.
ambiguousSet := ['E422','E425','E427','E428','E429','E430','E431','E504'];	
addrvalflag(STRING4 stat) := MAP(stat IN invalidSet => 'N',  // probably need to account for a miss with a blank
						   stat IN ambiguousSet => 'M',
						   stat = '' => '',  // guessing here that a miss should return a blank
						   'V');	    

layout_output intoOutLayout(indata le, resu ri) := transform
	self.seq := le.seq;
	self.did := ri.did;
	self.addrvalflag := IF(le.in_streetAddress<>'',addrvalflag(le.addr_status),'');
	self.dwelltype := dwelltype(le.addr_type);
	self.dl_number := le.dl_number;
	self.dl_state := le.dl_state;
	self.lat := le.lat;
	self.long := le.long;
	self.score := ri.score;
	
	self.hphonestateflag := '0';	// this is moving to instantid function
	
	self.firstscore := 255;
	self.lastscore := 255;
	self.hphonescore := 255;
	self.wphonescore := 255;
	self.socsscore := 255;
	self.dobscore := 255;
	self.addrscore := 255;
	self.cmpyscore := 255;

	self := le;
end;

bestrecs_pre := JOIN(resu,indata,LEFT.seq=RIGHT.seq, intoOutLayout(RIGHT, LEFT), LOOKUP);
bestrecs := bestrecs_pre;//GROUP(sort(bestrecs_pre,seq),seq);

layout_output addZipClass(layout_output le, riskwise.Key_CityStZip rt) := transform
	self.zipclass := rt.zipclass;
	self.ziptypeflag := MAP(length(Stringlib.StringFilter(le.in_zipCode,'0123456789')) < 5 and StringLib.StringFilterOut(le.in_zipCode,'0123456789') = '' => '6',
					    rt.zipclass = 'U' => '2',
					    rt.zipclass = 'M' => '3',
					    rt.zipclass = '' => '0',
					    rt.zipclass = 'P' => '1',
					    rt.zipclass <> '' => '4',
					    '5');
	self.statezipflag := IF(rt.state <> '' and StringLib.StringToUpperCase(le.in_state) <> rt.state, '1', '0');
	self.cityzipflag := IF(rt.city <> '' and le.in_city <> '' and (LnameScore(StringLib.StringToUpperCase(le.in_city), rt.city) < 80), '1', '0');
	
	self := le;
end;

wZipClass := join(bestrecs, riskwise.Key_CityStZip,
				keyed(right.zip5=left.in_zipCode) and left.in_zipCode!='',
				addZipClass(left, right), left outer, ATMOST(keyed(right.zip5=left.in_zipCode),RiskWise.max_atmost));


layout_output zipRoll(layout_output le, layout_output ri) := transform
	self.ziptypeflag := IF(le.ziptypeflag  not in ['4','5'], le.ziptypeflag, ri.ziptypeflag);
	self.statezipflag := IF(le.statezipflag = '0', le.statezipflag, ri.statezipflag);
	self.cityzipflag := IF(le.cityzipflag = '0', le.cityzipflag, ri.cityzipflag);
	
	self := le;
end;
wZipClassRoll := ROLLUP(wZipClass,true,zipRoll(left,right));


// add this here for cases where we found no did but can get one from the input social
// this will produce two (same) transforms: for regular key and fcra-key
MAC_getDID_transform (trans_name, key_ssntable) := MACRO
layout_output trans_name(layout_output le, key_ssntable ri) := transform
	self.did := if(ri.bestCount=1, ri.bestDID, le.did);
	self := le;
end;
ENDMACRO;
MAC_getDID_transform (getDID, risk_indicators.key_ssn_table_v2);
MAC_getDID_transform (getDIDFCRA, risk_indicators.key_ssn_table_FCRA_v2);

got_DIDbySSN := if(isFCRA, join (wZipClassRoll, risk_indicators.key_ssn_table_FCRA_v2,
							left.ssn!='' and keyed(left.ssn=right.ssn) AND (RIGHT.header_first_seen < history_date) and (left.did=0 OR left.score <= 1),
							getDIDFCRA(left,right),left outer, ATMOST(keyed(left.ssn=right.ssn),10), keep(1)),
					   join (wZipClassRoll, risk_indicators.key_ssn_table_v2,
							left.ssn!='' and keyed(left.ssn=right.ssn) AND (RIGHT.header_first_seen < history_date) and (left.did=0 OR left.score <= 1),
							getDID(left,right),left outer, ATMOST(keyed(left.ssn=right.ssn),10), keep(1)));


withADLVelocity := Boca_Shell_ADL(got_DIDbySSN);	// real time BocaShell 2 stuff

adlRec := if(history_date = 999999 and BSversion>1, withADLVelocity, got_DIDbySSN);	// skip the realtime velocity stuff if history run
																								

layout_outx := RECORD
	layout_output;
	header.layout_header h;
END;


layout_outx getHeader(layout_output le, doxie.key_header ri) := TRANSFORM
	SELF.header_footprint := 1;
	SELF.h := PROJECT(ri, TRANSFORM(header.Layout_Header, SELF := LEFT));
	
	ssn2use := IF ( ~mdr.Source_is_DPPA(ri.src) or dppa IN [1,4,6] or isFCRA, 
					IF(ri.valid_ssn<>'M',ri.ssn, ''), '');
	
	dt_last := MAP(ri.dt_last_seen<>0 => ri.dt_last_seen, 
						ri.dt_vendor_last_reported<>0 => ri.dt_vendor_last_reported,
						ri.dt_first_seen<>0 => ri.dt_first_seen,
						ri.dt_vendor_first_reported);
						
	dt_first := MAP(ri.dt_first_seen<>0 => ri.dt_first_seen,
						ri.dt_vendor_first_reported);
						
	isrecent := myDaysApart(myGetDate,((STRING6)dt_last+'31'));
	
	firstmatch_score := FnameScore(le.fname,ri.fname);
	firstmatch := g(firstmatch_score);
	lastmatch_score := LnameScore(le.lname, ri.lname);
	lastmatch := g(lastmatch_score);
	addrmatchscore := Risk_Indicators.AddrScore(le.prim_range, le.prim_name, le.sec_range, le.in_zipcode,
								 ri.prim_range, ri.prim_name, ri.sec_range, ri.zip);
	addrmatch := ga(addrmatchscore);
	hphonematchscore := PhoneScore(le.phone10, ri.phone);
	hphonematch := gn(hphonematchscore);
	wphonematchscore := PhoneScore(le.wphone10, ri.phone);
	wphonematch := gn(wphonematchscore);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ssn2use, LENGTH(TRIM(le.ssn))=4);
	socsmatch := gn(socsmatchscore);
	cmpymatch := false;
	dobmatch_score1 := IF(LENGTH(trim(le.dob))=8 and trim(ri.dob[1..8])<>'0',did_add.ssn_match_score(le.dob[1..8],ri.dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	dobmatch_score := if(dobmatch_score1 = 70 and (le.dob[7..8] = '00' or ri.dob[7..8] = '00'), 95, dobmatch_score1);
	dobmatch := g(dobmatch_score);
	
	SELF.trueDID := ri.did<>0;
	
	self.src := map(
	       ri.src[2] in ['D','V','W'] AND ~(ri.src IN ['MW','UW'])		=> ri.src[2],
				 ri.src IN ['TU','LT']	=> 'TU',
				 ri.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 ri.src IN ['MI','MA'] => 'XX', // won't count these
				 // ri.src in ['UT','UW','MU'] => 'UT', // no utility should come through
				 ri.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 ri.src);

	bad_source := ri.src IN ['MI','MA'];
	
	self.dt_last_seen := dt_last;
	
	
	// adding adl stuff here for BocaShell version 2
	self.ssn_from_did := if(history_date=999999, le.ssn_from_did, if(~bad_source, ri.ssn, ''));
	self.ssns_per_adl := if(history_date=999999, le.ssns_per_adl, if(trim(ri.ssn) <> '' and ~bad_source, 1, 0));
	self.ssns_per_adl_created_6months := if(history_date=999999, le.ssns_per_adl_created_6months, if(trim(ri.ssn) <> '' and ut.DaysApart(myGetDate, ri.dt_first_seen[1..6]+'31') < 183 and ~bad_source, 1, 0));
	
	self.addr_from_did := if(history_date=999999, le.addr_from_did, if(~bad_source, trim(ri.prim_range) + trim(ri.prim_name), ''));
	self.addrs_per_adl := if(history_date=999999, le.addrs_per_adl, if(trim(self.addr_from_did)!='' and ~bad_source, 1, 0));
	self.addrs_per_adl_created_6months := if(history_date=999999, le.addrs_per_adl_created_6months, if(trim(self.addr_from_did) != '' and ut.DaysApart(myGetDate, ri.dt_first_seen[1..6]+'31') < 183 and ~bad_source, 1, 0));
	
	fsDate31 := ri.dt_first_seen+'31';
	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;
	
	self.last_from_did := if(history_date=999999, le.last_from_did, if(~bad_source, ri.lname, ''));
	self.lnames_per_adl := if(history_date=999999, le.lnames_per_adl, if(trim(ri.lname)<>'' and ~bad_source, 1, 0));
	self.lnames_per_adl30 := if(history_date=999999, le.lnames_per_adl30, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,30), 1, 0));	
	self.lnames_per_adl90 := if(history_date=999999, le.lnames_per_adl90, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,90), 1, 0));
	self.lnames_per_adl180 := if(history_date=999999, le.lnames_per_adl180, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,180), 1, 0));
	self.lnames_per_adl12 := if(history_date=999999, le.lnames_per_adl12, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(1)), 1, 0));
	self.lnames_per_adl24 := if(history_date=999999, le.lnames_per_adl24, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(2)), 1, 0));
	self.lnames_per_adl36 := if(history_date=999999, le.lnames_per_adl36, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(3)), 1, 0));
	self.lnames_per_adl60 := if(history_date=999999, le.lnames_per_adl60, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(5)), 1, 0));
	self.newest_lname_dt_first_seen := if(history_date=999999, le.newest_lname_dt_first_seen, if(trim(ri.lname)<>'' and ~bad_source, ri.dt_last_seen, 0));

	self.addrs_last_5years := if(history_date=999999, le.addrs_last_5years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 500 and ~bad_source, 1, 0)); // within the last 5 years
	self.addrs_last_10years := if(history_date=999999, le.addrs_last_10years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 1000 and ~bad_source, 1, 0)); // within the last 10 years
	self.addrs_last_15years := if(history_date=999999, le.addrs_last_15years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 1500 and ~bad_source, 1, 0)); // within the last 15 years
 
	// Additional addr count stuff for attributes 2.0
	self.addrs_last30 := if(history_Date=999999, le.addrs_last30, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,30) and ~bad_source, 1, 0));
	self.addrs_last90 := if(history_Date=999999, le.addrs_last90, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,90) and ~bad_source, 1, 0));
	self.addrs_last12 := if(history_Date=999999, le.addrs_last12, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,ut.DaysInNYears(1)) and ~bad_source, 1, 0));
	self.addrs_last24 := if(history_Date=999999, le.addrs_last24, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,ut.DaysInNYears(2)) and ~bad_source, 1, 0));
	self.addrs_last36 := if(history_Date=999999, le.addrs_last36, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,ut.DaysInNYears(3)) and ~bad_source, 1, 0));
	////////////////////////
				 
				 
	self.firstcount := IF(firstmatch,1,0);
	self.lastcount := IF(lastmatch,1,0);
	self.addrcount := IF(isrecent and addrmatch,1,0);
	self.socscount := IF(socsmatch,1,0);
	self.hphonecount := IF(hphonematch,1,0);
	self.wphonecount := IF(wphonematch,1,0);
	self.cmpycount := IF(cmpymatch,1,0);
	self.dobcount := IF(dobmatch,1,0);
	
	
	self.eqfsfirstcount := (firstmatch and self.src = 'EQ');
	self.eqfslastcount := (lastmatch and self.src = 'EQ');
	self.eqfsaddrcount := (isrecent and addrmatch and self.src = 'EQ');
	self.eqfssocscount := (socsmatch and self.src = 'EQ');

	self.tufirstcount := (firstmatch and self.src ='TU');
	self.tulastcount := (lastmatch and self.src ='TU');
	self.tuaddrcount := (isrecent and addrmatch and self.src ='TU');
	self.tusocscount := (socsmatch and self.src ='TU');

	self.dlfirstcount := (firstmatch and self.src = 'D');
	self.dllastcount := (lastmatch and self.src = 'D');
	self.dladdrcount := (isrecent and addrmatch and self.src = 'D');
	self.dlsocscount := (socsmatch and self.src = 'D');

	self.emfirstcount := (firstmatch and self.src = 'EM');
	self.emlastcount := (lastmatch and self.src = 'EM');
	self.emaddrcount := (isrecent and addrmatch and self.src = 'EM');
	self.emsocscount := (socsmatch and self.src = 'EM');

	self.bkfirstcount := (firstmatch and self.src = 'BA');
	self.bklastcount := (lastmatch and self.src = 'BA');
	self.bkaddrcount := (isrecent and addrmatch and self.src = 'BA');
	self.bksocscount := (socsmatch and self.src = 'BA');

	SELF.adl_eqfs_first_seen := IF(self.src='EQ',ri.dt_first_seen, 0); 
	SELF.adl_eqfs_last_seen := IF(self.src='EQ',ri.dt_last_seen, 0);
	
	// add other sources like equifax for BocaShell version 2
	self.EQ_count := if(self.src='EQ', 1, 0);
	self.TU_count := if(self.src='TU', 1, 0);
	self.DL_count := if(self.src='D', 1, 0);
	self.PR_count := if(self.src='P', 1, 0);
	self.V_count := if(self.src='V', 1, 0);
	self.EM_count := if(self.src='EM', 1, 0);
	self.W_count := if(self.src='W', 1, 0);
	self.adl_TU_first_seen := if(self.src='TU', ri.dt_first_seen, 0);
	self.adl_TU_last_seen := if(self.src='TU', ri.dt_last_seen, 0);
	self.adl_DL_first_seen := if(self.src='D', ri.dt_first_seen, 0);
	self.adl_DL_last_seen := if(self.src='D', ri.dt_last_seen, 0);
	self.adl_PR_first_seen := if(self.src='P', ri.dt_first_seen, 0);
	self.adl_PR_last_seen := if(self.src='P', ri.dt_last_seen, 0);
	self.adl_V_first_seen := if(self.src='V', ri.dt_first_seen, 0);
	self.adl_V_last_seen := if(self.src='V', ri.dt_last_seen, 0);
	self.adl_EM_first_seen := if(self.src='EM', ri.dt_first_seen, 0);
	self.adl_EM_last_seen := if(self.src='EM', ri.dt_last_seen, 0);
	self.adl_W_first_seen := if(self.src='W', ri.dt_first_seen, 0);
	self.adl_W_last_seen := if(self.src='W', ri.dt_last_seen, 0);
	
	
	SELF.adl_other_first_seen := IF(self.src<>'EQ',ri.dt_first_seen, 0);
	SELF.adl_other_last_seen := IF(self.src<>'EQ',ri.dt_last_seen, 0);

	SELF.chrono_sources := IF(bad_source, le.chrono_sources, SELF.src+',');
	SELF.chrono_addrcount := 1;	// this is allowing bad sources and this is the addr section of the bocashell count field
	SELF.chrono_eqfsaddrcount := SELF.src='EQ';
	SELF.chrono_dladdrcount := SELF.src='D';
	SELF.chrono_emaddrcount := SELF.src='EM';

	self.chronofirst := ri.fname;
	self.chronolast := ri.lname;
	self.chronoprim_range := ri.prim_range;
	self.chronopredir := ri.predir;
	self.chronoprim_name := ri.prim_name;
	self.chronosuffix := ri.suffix;
	self.chronopostdir := ri.postdir;
	self.chronounit_desig := ri.unit_desig;
	self.chronosec_range := ri.sec_range;
	self.chronocity := ri.city_name;
	self.chronostate := ri.st;
	self.chronozip := ri.zip;
	self.chronozip4 := ri.zip4;
	self.chronocounty := ri.county;
	self.chronogeo_blk := ri.geo_blk;
	self.chronodate_first := dt_first;
	self.chronodate_last := dt_last;
	self.chronoaddrscore := addrmatchscore;
	
	// look for soc matches, preferring valid='G' in the rollup below
	self.socsscore := socsmatchscore;
	self.versocs := ssn2use;//ri.ssn;		// this seems to make more sense, right?
	self.socsvalid := ri.valid_ssn;
	
	// if input social is 4 bytes then use full social from header if last4 match
	self.ssn := if(length(trim(le.ssn)) = 4 and socsmatch, ssn2use, le.ssn);
	
	// try recent addresses
	self.addrscore := IF(isrecent,addrmatchscore,255);
	self.addrmultiple := false;
	
	self.verprim_range := IF(isrecent,ri.prim_range,'');
	self.verpredir := IF(isrecent,ri.predir,'');
	self.verprim_name := IF(isrecent,ri.prim_name,'');
	self.versuffix := IF(isrecent,ri.suffix,'');
	self.verpostdir := IF(isrecent,ri.postdir,'');
	self.verunit_desig := IF(isrecent,ri.unit_desig,'');
	self.versec_range := IF(isrecent,ri.sec_range,'');
	self.vercity := IF(isrecent, ri.city_name, '');
	self.verstate := IF(isrecent, ri.st, '');
	self.verzip := IF(isrecent, ri.zip+ri.zip4, '');
	self.vercounty := IF(isrecent, ri.county, '');
	self.vergeo_blk := IF(isrecent, ri.geo_blk, '');
	SELF.verdate_last := IF(isrecent, ri.dt_last_seen, 0);
	SELF.verdate_first := IF(isrecent, ri.dt_first_seen, 0);
	
	self.lastscore := lastmatch_score;
	self.verlast := ri.lname;

	self.firstscore := firstmatch_score;
	self.verfirst := ri.fname;
	
	self.dobscore := dobmatch_score;
	self.verdob := (STRING)ri.dob;
	
	self.hphonescore := hphonematchscore;
	self.verhphone := ri.phone;
	
	self.wphonescore := wphonematchscore;
	self.verwphone := '';//ri.phone;  // not sure how to handle this yet

	SELF.sources := IF(bad_source,le.sources,SELF.src+',');	
	SELF.firstnamesources := IF(bad_source OR SELF.firstcount=0,le.firstnamesources,SELF.src+',');
	SELF.lastnamesources := IF(bad_source OR SELF.lastcount=0,le.lastnamesources,SELF.src+',');
	SELF.addrsources := IF(bad_source OR SELF.addrcount=0,le.addrsources,SELF.src+',');
	SELF.socssources := IF(bad_source OR SELF.socscount=0,le.socssources,SELF.src+',');
	SELF.numsource := IF(bad_source,0,1);
	
	self.hphonesources := IF(bad_source OR SELF.hphonecount=0,le.hphonesources,SELF.src+',');
	self.wphonesources := IF(bad_source OR SELF.wphonecount=0,le.wphonesources,SELF.src+',');
	self.dobsources := IF(bad_source OR SELF.dobcount=0,le.dobsources,SELF.src+',');
	self.cmpysources := IF(bad_source OR SELF.cmpycount=0,le.cmpysources,SELF.src+',');
	
	derog_source := ri.src IN ['C','BA','LI','L2','FR'];// any others?
	lsDate31 := ri.dt_last_seen+'31';
	self.num_nonderogs := if(~bad_source and ~derog_source, 1, 0);
	self.num_nonderogs30 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,30), 1, 0);
	self.num_nonderogs90 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,90), 1, 0);
	self.num_nonderogs180 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,180), 1, 0);
	self.num_nonderogs12 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(1)), 1, 0);
	self.num_nonderogs24 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(2)), 1, 0);
	self.num_nonderogs36 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(3)), 1, 0);
	self.num_nonderogs60 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(5)), 1, 0);
		
	self := le;
end;


j_pre := join (adlRec, doxie.key_header,
               LEFT.did<>0 AND keyed(LEFT.did = RIGHT.s_did) AND
							 (RIGHT.dt_first_seen < history_date and right.dt_vendor_first_reported < history_date) and // check date,
               (~mdr.Source_is_Utility(RIGHT.src) AND // rm Utility from NAS
               (header.isPreGLB(RIGHT) OR glb_ok) AND
               (~mdr.Source_is_DPPA(RIGHT.src) OR
				  (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))
				   or isFCRA) AND  // FCRA sees all sources
               ~mdr.Source_is_on_Probation(RIGHT.src) AND // we won't use probation data 
               // we won't use experian dl's/vehicles (requires LN branding)
               (ln_branded OR ~(dppa_ok AND RIGHT.src[2] IN ['E','X'])) and
               (~isFCRA or ~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]))), //FCRA
               getHeader(LEFT,RIGHT), LEFT OUTER, LIMIT(ut.limits .HEADER_PER_DID, SKIP));
			
			
// JRP 01/31/08 - BOM - Added Quick Header
layout_outx getQuickHeader(layout_output le, header_quick.key_did ri) := TRANSFORM
	SELF.header_footprint := 1;
	
	// consider all QH sourced records to be equifax records for the purpose of this transform
	source := 'EQ';
	SELF.h := PROJECT(ri, TRANSFORM(header.Layout_Header, self.src := source, SELF := LEFT));
	
	ssn2use := IF ( ~mdr.Source_is_DPPA(source) or dppa IN [1,4,6] or isFCRA, 
					IF(ri.valid_ssn<>'M',ri.ssn, ''), '');
	
	dt_last := MAP(ri.dt_last_seen<>0 => ri.dt_last_seen, 
						ri.dt_vendor_last_reported<>0 => ri.dt_vendor_last_reported,
						ri.dt_first_seen<>0 => ri.dt_first_seen,
						ri.dt_vendor_first_reported);
						
	dt_first := MAP(ri.dt_first_seen<>0 => ri.dt_first_seen,
						ri.dt_vendor_first_reported);
						
	isrecent := myDaysApart(myGetDate,((STRING6)dt_last+'31'));
	
	firstmatch_score := FnameScore(le.fname,ri.fname);
	firstmatch := g(firstmatch_score);
	lastmatch_score := LnameScore(le.lname, ri.lname);
	lastmatch := g(lastmatch_score);
	addrmatchscore := Risk_Indicators.AddrScore(le.prim_range, le.prim_name, le.sec_range, le.in_zipcode,
								 ri.prim_range, ri.prim_name, ri.sec_range, ri.zip);
	addrmatch := ga(addrmatchscore);
	hphonematchscore := PhoneScore(le.phone10, ri.phone);
	hphonematch := gn(hphonematchscore);
	wphonematchscore := PhoneScore(le.wphone10, ri.phone);
	wphonematch := gn(wphonematchscore);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ssn2use, LENGTH(TRIM(le.ssn))=4);
	socsmatch := gn(socsmatchscore);
	cmpymatch := false;
	dobmatch_score1 := IF(LENGTH(trim(le.dob))=8 and trim(ri.dob[1..8])<>'0',did_add.ssn_match_score(le.dob[1..8],ri.dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	dobmatch_score := if(dobmatch_score1 = 70 and (le.dob[7..8] = '00' or ri.dob[7..8] = '00'), 95, dobmatch_score1);
	dobmatch := g(dobmatch_score);
	
	SELF.trueDID := ri.did<>0;
	
	self.src := source;

	bad_source := source IN ['MI','MA'];
	
	self.dt_last_seen := dt_last;
	
	
	// adding adl stuff here for BocaShell version 2
	self.ssn_from_did := if(history_date=999999, le.ssn_from_did, if(~bad_source, ri.ssn, ''));
	self.ssns_per_adl := if(history_date=999999, le.ssns_per_adl, if(trim(ri.ssn) <> '' and ~bad_source, 1, 0));
	self.ssns_per_adl_created_6months := if(history_date=999999, le.ssns_per_adl_created_6months, if(trim(ri.ssn) <> '' and ut.DaysApart(myGetDate, ri.dt_first_seen[1..6]+'31') < 183 and ~bad_source, 1, 0));
	
	self.addr_from_did := if(history_date=999999, le.addr_from_did, if(~bad_source, trim(ri.prim_range) + trim(ri.prim_name), ''));
	self.addrs_per_adl := if(history_date=999999, le.addrs_per_adl, if(trim(self.addr_from_did)!='' and ~bad_source, 1, 0));
	self.addrs_per_adl_created_6months := if(history_date=999999, le.addrs_per_adl_created_6months, if(trim(self.addr_from_did) != '' and ut.DaysApart(myGetDate, ri.dt_first_seen[1..6]+'31') < 183 and ~bad_source, 1, 0));
	
	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;
	fsDate31 := ri.dt_first_seen+'31';
	
	self.last_from_did := if(history_date=999999, le.last_from_did, if(~bad_source, ri.lname, ''));
	self.lnames_per_adl := if(history_date=999999, le.lnames_per_adl, if(trim(ri.lname)<>'' and ~bad_source, 1, 0));
	self.lnames_per_adl30 := if(history_date=999999, le.lnames_per_adl30, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,30), 1, 0));	
	self.lnames_per_adl90 := if(history_date=999999, le.lnames_per_adl90, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,90), 1, 0));
	self.lnames_per_adl180 := if(history_date=999999, le.lnames_per_adl180, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,180), 1, 0));
	self.lnames_per_adl12 := if(history_date=999999, le.lnames_per_adl12, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(1)), 1, 0));
	self.lnames_per_adl24 := if(history_date=999999, le.lnames_per_adl24, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(2)), 1, 0));
	self.lnames_per_adl36 := if(history_date=999999, le.lnames_per_adl36, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(3)), 1, 0));
	self.lnames_per_adl60 := if(history_date=999999, le.lnames_per_adl60, if(trim(ri.lname)<>'' and ~bad_source and checkDays(myGetDate,fsDate31,ut.DaysInNYears(5)), 1, 0));
	self.newest_lname_dt_first_seen := if(history_date=999999, le.newest_lname_dt_first_seen, if(trim(ri.lname)<>'' and ~bad_source, ri.dt_last_seen, 0));
	
	self.addrs_last_5years := if(history_date=999999, le.addrs_last_5years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 500 and ~bad_source, 1, 0)); // within the last 5 years
	self.addrs_last_10years := if(history_date=999999, le.addrs_last_10years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 1000 and ~bad_source, 1, 0)); // within the last 10 years
	self.addrs_last_15years := if(history_date=999999, le.addrs_last_15years, if(( (unsigned)myGetDate[1..6] - (unsigned)ri.dt_first_seen[1..6] ) < 1500 and ~bad_source, 1, 0)); // within the last 15 years
  
	// Additional addr count stuff for attributes 2.0
	
	self.addrs_last30 := if(history_Date=999999, le.addrs_last30, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,30) and ~bad_source, 1, 0));
	self.addrs_last90 := if(history_Date=999999, le.addrs_last90, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,90) and ~bad_source, 1, 0));
	self.addrs_last12 := if(history_Date=999999, le.addrs_last12, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,365) and ~bad_source, 1, 0));
	self.addrs_last24 := if(history_Date=999999, le.addrs_last24, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,730) and ~bad_source, 1, 0));
	self.addrs_last36 := if(history_Date=999999, le.addrs_last36, if(trim(self.addr_from_did) != '' and checkDays(myGetDate,fsDate31,1095) and ~bad_source, 1, 0));
	////////////////////////
				 
				 
	self.firstcount := IF(firstmatch,1,0);
	self.lastcount := IF(lastmatch,1,0);
	self.addrcount := IF(isrecent and addrmatch,1,0);
	self.socscount := IF(socsmatch,1,0);
	self.hphonecount := IF(hphonematch,1,0);
	self.wphonecount := IF(wphonematch,1,0);
	self.cmpycount := IF(cmpymatch,1,0);
	self.dobcount := IF(dobmatch,1,0);
	
	
	self.eqfsfirstcount := (firstmatch and self.src = 'EQ');
	self.eqfslastcount := (lastmatch and self.src = 'EQ');
	self.eqfsaddrcount := (isrecent and addrmatch and self.src = 'EQ');
	self.eqfssocscount := (socsmatch and self.src = 'EQ');

	self.tufirstcount := (firstmatch and self.src ='TU');
	self.tulastcount := (lastmatch and self.src ='TU');
	self.tuaddrcount := (isrecent and addrmatch and self.src ='TU');
	self.tusocscount := (socsmatch and self.src ='TU');

	self.dlfirstcount := (firstmatch and self.src = 'D');
	self.dllastcount := (lastmatch and self.src = 'D');
	self.dladdrcount := (isrecent and addrmatch and self.src = 'D');
	self.dlsocscount := (socsmatch and self.src = 'D');

	self.emfirstcount := (firstmatch and self.src = 'EM');
	self.emlastcount := (lastmatch and self.src = 'EM');
	self.emaddrcount := (isrecent and addrmatch and self.src = 'EM');
	self.emsocscount := (socsmatch and self.src = 'EM');

	self.bkfirstcount := (firstmatch and self.src = 'BA');
	self.bklastcount := (lastmatch and self.src = 'BA');
	self.bkaddrcount := (isrecent and addrmatch and self.src = 'BA');
	self.bksocscount := (socsmatch and self.src = 'BA');

	SELF.adl_eqfs_first_seen := IF(self.src='EQ',ri.dt_first_seen, 0); 
	SELF.adl_eqfs_last_seen := IF(self.src='EQ',ri.dt_last_seen, 0);
	
	// add other sources like equifax for BocaShell version 2
	self.EQ_count := if(self.src='EQ', 1, 0);
	self.TU_count := if(self.src='TU', 1, 0);
	self.DL_count := if(self.src='D', 1, 0);
	self.PR_count := if(self.src='P', 1, 0);
	self.V_count := if(self.src='V', 1, 0);
	self.EM_count := if(self.src='EM', 1, 0);
	self.W_count := if(self.src='W', 1, 0);
	self.adl_TU_first_seen := if(self.src='TU', ri.dt_first_seen, 0);
	self.adl_TU_last_seen := if(self.src='TU', ri.dt_last_seen, 0);
	self.adl_DL_first_seen := if(self.src='D', ri.dt_first_seen, 0);
	self.adl_DL_last_seen := if(self.src='D', ri.dt_last_seen, 0);
	self.adl_PR_first_seen := if(self.src='P', ri.dt_first_seen, 0);
	self.adl_PR_last_seen := if(self.src='P', ri.dt_last_seen, 0);
	self.adl_V_first_seen := if(self.src='V', ri.dt_first_seen, 0);
	self.adl_V_last_seen := if(self.src='V', ri.dt_last_seen, 0);
	self.adl_EM_first_seen := if(self.src='EM', ri.dt_first_seen, 0);
	self.adl_EM_last_seen := if(self.src='EM', ri.dt_last_seen, 0);
	self.adl_W_first_seen := if(self.src='W', ri.dt_first_seen, 0);
	self.adl_W_last_seen := if(self.src='W', ri.dt_last_seen, 0);
	
	
	SELF.adl_other_first_seen := IF(self.src<>'EQ',ri.dt_first_seen, 0);
	SELF.adl_other_last_seen := IF(self.src<>'EQ',ri.dt_last_seen, 0);

	SELF.chrono_sources := IF(bad_source, le.chrono_sources, SELF.src+',');
	SELF.chrono_addrcount := 1;	// this is allowing bad sources and this is the addr section of the bocashell count field
	SELF.chrono_eqfsaddrcount := SELF.src='EQ';
	SELF.chrono_dladdrcount := SELF.src='D';
	SELF.chrono_emaddrcount := SELF.src='EM';

	self.chronofirst := ri.fname;
	self.chronolast := ri.lname;
	self.chronoprim_range := ri.prim_range;
	self.chronopredir := ri.predir;
	self.chronoprim_name := ri.prim_name;
	self.chronosuffix := ri.suffix;
	self.chronopostdir := ri.postdir;
	self.chronounit_desig := ri.unit_desig;
	self.chronosec_range := ri.sec_range;
	self.chronocity := ri.city_name;
	self.chronostate := ri.st;
	self.chronozip := ri.zip;
	self.chronozip4 := ri.zip4;
	self.chronocounty := ri.county;
	self.chronogeo_blk := ri.geo_blk;
	self.chronodate_first := dt_first;
	self.chronodate_last := dt_last;
	self.chronoaddrscore := addrmatchscore;
	
	// look for soc matches, preferring valid='G' in the rollup below
	self.socsscore := socsmatchscore;
	self.versocs := ssn2use;//ri.ssn;		// this seems to make more sense, right?
	self.socsvalid := ri.valid_ssn;
	
	// if input social is 4 bytes then use full social from header if last4 match
	self.ssn := if(length(trim(le.ssn)) = 4 and socsmatch, ssn2use, le.ssn);
	
	// try recent addresses
	self.addrscore := IF(isrecent,addrmatchscore,255);
	self.addrmultiple := false;
	
	self.verprim_range := IF(isrecent,ri.prim_range,'');
	self.verpredir := IF(isrecent,ri.predir,'');
	self.verprim_name := IF(isrecent,ri.prim_name,'');
	self.versuffix := IF(isrecent,ri.suffix,'');
	self.verpostdir := IF(isrecent,ri.postdir,'');
	self.verunit_desig := IF(isrecent,ri.unit_desig,'');
	self.versec_range := IF(isrecent,ri.sec_range,'');
	self.vercity := IF(isrecent, ri.city_name, '');
	self.verstate := IF(isrecent, ri.st, '');
	self.verzip := IF(isrecent, ri.zip+ri.zip4, '');
	self.vercounty := IF(isrecent, ri.county, '');
	self.vergeo_blk := IF(isrecent, ri.geo_blk, '');
	SELF.verdate_last := IF(isrecent, ri.dt_last_seen, 0);
	SELF.verdate_first := IF(isrecent, ri.dt_first_seen, 0);
	
	self.lastscore := lastmatch_score;
	self.verlast := ri.lname;

	self.firstscore := firstmatch_score;
	self.verfirst := ri.fname;
	
	self.dobscore := dobmatch_score;
	self.verdob := (STRING)ri.dob;
	
	self.hphonescore := hphonematchscore;
	self.verhphone := ri.phone;
	
	self.wphonescore := wphonematchscore;
	self.verwphone := '';//ri.phone;  // not sure how to handle this yet

	SELF.sources := IF(bad_source,le.sources,SELF.src+',');	
	SELF.firstnamesources := IF(bad_source OR SELF.firstcount=0,le.firstnamesources,SELF.src+',');
	SELF.lastnamesources := IF(bad_source OR SELF.lastcount=0,le.lastnamesources,SELF.src+',');
	SELF.addrsources := IF(bad_source OR SELF.addrcount=0,le.addrsources,SELF.src+',');
	SELF.socssources := IF(bad_source OR SELF.socscount=0,le.socssources,SELF.src+',');
	SELF.numsource := IF(bad_source,0,1);
	
	self.hphonesources := IF(bad_source OR SELF.hphonecount=0,le.hphonesources,SELF.src+',');
	self.wphonesources := IF(bad_source OR SELF.wphonecount=0,le.wphonesources,SELF.src+',');
	self.dobsources := IF(bad_source OR SELF.dobcount=0,le.dobsources,SELF.src+',');
	self.cmpysources := IF(bad_source OR SELF.cmpycount=0,le.cmpysources,SELF.src+',');
	
	derog_source := source IN ['C','BA','LI','L2','FR'];// any others?
	lsDate31 := ri.dt_last_seen+'31';
	self.num_nonderogs := if(~bad_source and ~derog_source, 1, 0);
	self.num_nonderogs30 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,30), 1, 0);
	self.num_nonderogs90 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,90), 1, 0);
	self.num_nonderogs180 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,180), 1, 0);
	self.num_nonderogs12 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(1)), 1, 0);
	self.num_nonderogs24 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(2)), 1, 0);
	self.num_nonderogs36 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(3)), 1, 0);
	self.num_nonderogs60 := if(~bad_source and ~derog_source and checkDays(myGetDate,lsDate31,ut.DaysInNYears(5)), 1, 0);
		
	self := le;
end;


j_quickpre := join (adlRec, header_quick.key_did,
               LEFT.did<>0 AND keyed(LEFT.did = RIGHT.did) AND 
			   glb_ok and
			   (RIGHT.dt_first_seen < history_date and right.dt_vendor_first_reported < history_date), // check date,
               getQuickHeader(LEFT,RIGHT), LIMIT(ut.limits .HEADER_PER_DID, SKIP));


allheader := group( sort( ungroup(j_pre + j_quickpre), seq ), seq);

					
ssn_addr_rolled := getVelocityHist(allheader, history_date);//  history BocaShell 2 stuff
adl_rolled := if(history_date = 999999, allheader, ssn_addr_rolled);// ssn_addr_rolled may not be all inclusive here

phones_rolled := if(BSversion>1, getPhoneAddrVelocity(adl_rolled, history_date), allheader);	// currently not using key_phone_table for real time because it is calculated differently,
																		// also, defaulting to allheader in BocaShell version 1						
			
// JRP 01/31/08 - EOM


//=================================================================
//================= CORRECTIONS (fcra only) =======================
//=================================================================
// resu (grouped by seq) - dids and (optional?) ssn from didville.MAC_DidAppend
// Get all relevant corrections
layout_corr := 
RECORD
	unsigned4 seq;
	fcra.layout_override_pii;
END;

corr_by_did := JOIN (resu, FCRA.Key_Override_pii_DID,
                     (Left.did != 0) AND
                     keyed (Left.did = Right.s_did), TRANSFORM (layout_corr, SELF.seq := LEFT.seq, SELF := Right));

corr_by_ssn := JOIN (resu, FCRA.Key_Override_pii_SSN,
                     (Left.ssn != '') AND
                     keyed (Left.ssn = Right.ssn) AND
                     datalib.NameMatch (Left.fname,  Left.mname,  Left.lname, 
                                        Right.fname, Right.mname, Right.lname) < 3,
                     TRANSFORM (layout_corr, SELF.did := INTFORMAT(LEFT.did,12,0), SELF.seq := LEFT.seq, SELF := RIGHT));
										 // Set DID to LEFT record so that we will pick these up later

all_corrections := DEDUP (corr_by_did + corr_by_ssn, ALL);

// What we're doing here (j_pre - join with real header - already exists):
// a) transform corrections to layout_header, fake_header dataset.
// b) combine allheader wiht fake_header (ungrouping/grouping where required)

// Get correction part of the output
// first transform coorections to layout_header:
Layout_Header_seq :=
RECORD
	unsigned4 seq;
	header.Layout_Header;
END;

Layout_Header_seq TransformToHeader (layout_corr L) := TRANSFORM
  SELF.did := (unsigned6) L.did;
  SELF.rid := 0;
  SELF.src := 'CO';
  SELF.dt_first_seen := (unsigned3) (L.dt_first_seen [1..6]);
  SELF.dt_last_seen := (unsigned3) (L.dt_last_seen [1..6]);
  SELF.dob := (integer4) L.dob;
	SELF.Valid_SSN := 'G'; // G - we believe it to be correct for that person

  SELF := L;
  SELF := [];
END;
fake_header := PROJECT (all_corrections, TransformToHeader (Left));

//create "fake" header recs
layout_outx GetFakeHeaderRecords (layout_output le, Layout_Header_seq ri) := TRANSFORM
	SELF.header_footprint := 1;
	SELF.h := ri;
	
	ssn2use := ri.ssn;

 	dt := (unsigned3) (ut.GetDate[1..6]); // by definition, corrects are current
	isrecent := true; // see above
	
	firstmatch_score := Risk_Indicators.FnameScore(le.fname,ri.fname);
	firstmatch := Risk_Indicators.g(firstmatch_score);
	lastmatch_score := Risk_Indicators.LnameScore(le.lname, ri.lname);
	lastmatch := Risk_Indicators.g(lastmatch_score);
	addrmatchscore := Risk_Indicators.AddrScore(le.prim_range, le.prim_name, le.sec_range, le.in_zipcode,
									 ri.prim_range, ri.prim_name, ri.sec_range, ri.zip);
	
	addrmatch := Risk_Indicators.ga(addrmatchscore);
	hphonematchscore := Risk_Indicators.PhoneScore(le.phone10, ri.phone);
	hphonematch := gn(hphonematchscore);
	wphonematchscore := Risk_Indicators.PhoneScore(le.wphone10, ri.phone);
	wphonematch := gn(wphonematchscore);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ssn2use, LENGTH(TRIM(le.ssn))=4);
	socsmatch := gn(socsmatchscore);
	cmpymatch := false;
	dobmatch_score := IF(LENGTH(trim(le.dob))=8 and trim(ri.dob[1..8])<>'0',did_add.ssn_match_score(le.dob[1..8],ri.dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	dobmatch := Risk_Indicators.g(dobmatch_score);
	
	SELF.trueDID := ri.did<>0;
	
	self.src := ri.src;

	bad_source := false;
				 
	self.dt_last_seen := dt;			 
	self.firstcount := IF(firstmatch,1,0);
	self.lastcount := IF(lastmatch,1,0);
	self.addrcount := IF(isrecent and addrmatch,1,0);
	self.socscount := IF(socsmatch,1,0);
	self.hphonecount := IF(hphonematch,1,0);
	self.wphonecount := IF(wphonematch,1,0);
	self.cmpycount := IF(cmpymatch,1,0);
	self.dobcount := IF(dobmatch,1,0);

	SELF.chrono_sources := SELF.src+',';
	SELF.chrono_addrcount := 1;


	self.chronofirst := ri.fname;
	self.chronolast := ri.lname;
	self.chronoprim_range := ri.prim_range;
	self.chronopredir := ri.predir;
	self.chronoprim_name := ri.prim_name;
	self.chronosuffix := ri.suffix;
	self.chronopostdir := ri.postdir;
	self.chronounit_desig := ri.unit_desig;
	self.chronosec_range := ri.sec_range;
	self.chronocity := ri.city_name;
	self.chronostate := ri.st;
	self.chronozip := ri.zip;
	self.chronozip4 := ri.zip4;
	self.chronocounty := ri.county;
	self.chronogeo_blk := ri.geo_blk;
	self.chronodate_first := ri.dt_first_seen;
	self.chronodate_last := ri.dt_last_seen;
	self.chronoaddrscore := addrmatchscore;
	
	// look for soc matches, preferring valid='G' in the rollup below
	self.socsscore := socsmatchscore;
	self.versocs := ri.ssn;
	self.socsvalid := ri.valid_ssn;
	
	// try recent addresses
	self.addrscore := IF(isrecent,addrmatchscore,255);
	self.addrmultiple := false;
	
	self.verprim_range := IF(isrecent,ri.prim_range,'');
	self.verpredir := IF(isrecent,ri.predir,'');
	self.verprim_name := IF(isrecent,ri.prim_name,'');
	self.versuffix := IF(isrecent,ri.suffix,'');
	self.verpostdir := IF(isrecent,ri.postdir,'');
	self.verunit_desig := IF(isrecent,ri.unit_desig,'');
	self.versec_range := IF(isrecent,ri.sec_range,'');
	self.vercity := IF(isrecent, ri.city_name, '');
	self.verstate := IF(isrecent, ri.st, '');
	self.verzip := IF(isrecent, ri.zip+ri.zip4, '');
	self.vercounty := IF(isrecent, ri.county, '');
	self.vergeo_blk := IF(isrecent, ri.geo_blk, '');
	SELF.verdate_last := IF(isrecent, ri.dt_last_seen, 0);
	SELF.verdate_first := IF(isrecent, ri.dt_first_seen, 0);
	
	self.lastscore := lastmatch_score;
	self.verlast := ri.lname;

	self.firstscore := firstmatch_score;
	self.verfirst := ri.fname;
	
	self.dobscore := dobmatch_score;
	self.verdob := (STRING)ri.dob;
	
	self.hphonescore := hphonematchscore;
	self.verhphone := ri.phone;
	
	self.wphonescore := wphonematchscore;
	self.verwphone := '';//ri.phone;  // not sure how to handle this yet

	SELF.sources := IF(bad_source,le.sources,SELF.src+',');	
	SELF.firstnamesources := IF(bad_source OR SELF.firstcount=0,le.firstnamesources,SELF.src+',');
	SELF.lastnamesources := IF(bad_source OR SELF.lastcount=0,le.lastnamesources,SELF.src+',');
	SELF.addrsources := IF(bad_source OR SELF.addrcount=0,le.addrsources,SELF.src+',');
	SELF.socssources := IF(bad_source OR SELF.socscount=0,le.socssources,SELF.src+',');
	SELF.numsource := IF(bad_source,0,1);
	
	self.hphonesources := IF(bad_source OR SELF.hphonecount=0,le.hphonesources,SELF.src+',');
	self.wphonesources := IF(bad_source OR SELF.wphonecount=0,le.wphonesources,SELF.src+',');
	self.dobsources := IF(bad_source OR SELF.dobcount=0,le.dobsources,SELF.src+',');
	self.cmpysources := IF(bad_source OR SELF.cmpycount=0,le.cmpysources,SELF.src+',');
	
	self := le;
end;
j_corrections := join (adlRec, fake_header,
                       (Left.seq = Right.seq),
                       GetFakeHeaderRecords (Left, Right), MANY LOOKUP);
//========================================

j_combined := GROUP (SORT (UNGROUP(phones_rolled + j_corrections), seq), seq);

j_header := IF (isFCRA, j_combined, phones_rolled);

sortedGood := PROJECT (j_header,TRANSFORM(layout_output, SELF := LEFT));			


// this will produce two (same) transforms: for regular key and fcra-key
MAC_ssnTable_transform (trans_name, key_ssntable) := MACRO
layout_output trans_name (layout_output le, key_ssntable ri, INTEGER i) := transform

	isOver := suppress.check_ssnOver(le.did, le.ssn);
	
	self.ssnexists := IF(i=1,ri.ssn<>'',le.ssnexists);

	//self.did := IF(i=1,IF(le.did=0 AND ri.bestCount=1,ri.bestDID,le.did),le.did);
	
	vssn := Validate_SSN(le.ssn,'');
					
	self.socsvalflag := IF(i=1,MAP(isOver => '0', 
							 le.ssn='' => '3',
							 vssn.invalid => '2',
							 (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or 
							 vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
							 '0'),
					   le.socsvalflag);
					    	
	self.PWsocsvalflag := IF(i=1,MAP(isOver => '0', 
							   le.ssn='' => '6',
							   (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
							   le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   (UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(ut.GetDate[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 => '4',
							   // not sure what to do for 3 or 2
							   '0'),
						le.pwsocsvalflag);

	SELF.soclstate := IF(isOver, '', IF(i=1,ri.issue_state,le.soclstate));

	// Only EQ records go into last names.  So just remove these if you don't have GLB
	chooser1 := MAP(~glb_ok	=> 0,
				 ri.lname1.lname=le.lname AND ri.lname2.first_seen < history_date => 2,
				 ri.lname1.lname<>le.lname AND ri.lname1.first_seen < history_date => 1,
				 0);
	
	self.altfirst := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)ri.lname1.fname,
									2		=> 	(STRING20)ri.lname2.fname,
									''),
					le.altfirst);
	self.altlast := IF(i=1,CASE(chooser1,
									1		=> 	(STRING20)ri.lname1.lname,
									2		=> 	(STRING20)ri.lname2.lname,
									''),
				    le.altlast);
	self.altlast_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(ri.lname1.last_seen=0,'',(STRING8)ri.lname1.last_seen),
									2		=> 	IF(ri.lname2.last_seen=0,'',(STRING8)ri.lname2.last_seen),
									''),
					    le.altlast_date);
	self.altearly_date := IF(i=1,CASE(chooser1,
									1		=> 	IF(ri.lname1.first_seen=0,'',(STRING8)ri.lname1.first_seen),
									2		=> 	IF(ri.lname2.first_seen=0,'',(STRING8)ri.lname2.first_seen),
									''),
						le.altearly_date);
	
	chooser2 := MAP(~glb_ok	=> 0,
				 chooser1=1 AND ri.lname2.lname<>le.lname AND ri.lname2.first_seen < history_date => 2,
				 chooser1=2 AND ri.lname3.first_seen < history_date => 3,
				 0);
	
	self.altfirst2 := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)ri.lname2.fname,
									3		=> 	(STRING20)ri.lname3.fname,
									''),
					 le.altfirst2);
	self.altlast2 := IF(i=1,CASE(chooser2,
									2		=> 	(STRING20)ri.lname2.lname,
									3		=> 	(STRING20)ri.lname3.lname,
									''),
					le.altlast2);
	self.altlast_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(ri.lname2.last_seen=0,'',(STRING8)ri.lname2.last_seen),
									3		=> 	IF(ri.lname3.last_seen=0,'',(STRING8)ri.lname3.last_seen),
									''),
						le.altlast_date2);
	self.altearly_date2 := IF(i=1,CASE(chooser2,
									2		=> 	IF(ri.lname2.first_seen=0,'',(STRING8)ri.lname2.first_seen),
									3		=> 	IF(ri.lname3.first_seen=0,'',(STRING8)ri.lname3.first_seen),
									''),
						 le.altearly_date2);
	
	chooser3 := MAP(~glb_ok	=> 0,
				 chooser2=2 AND ri.lname3.lname<>le.lname AND ri.lname3.first_seen < history_date => 3,
				 chooser2=3 AND ri.lname4.first_seen < history_date => 4,
				 0);
	
	self.altfirst3 := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)ri.lname3.fname,
												4		=> 	(STRING20)ri.lname4.fname,
												''),
					 le.altfirst3);
	self.altlast3 := IF(i=1,CASE(chooser3,
												3		=> 	(STRING20)ri.lname3.lname,
												4		=> 	(STRING20)ri.lname4.lname,
												''),
					le.altlast3);
	self.altlast_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(ri.lname3.last_seen=0,'',(STRING8)ri.lname3.last_seen),
												4		=> 	IF(ri.lname4.last_seen=0,'',(STRING8)ri.lname4.last_seen),
												''),
						le.altlast_date3);
	self.altearly_date3 := IF(i=1,CASE(chooser3,
												3		=> 	IF(ri.lname3.first_seen=0,'',(STRING8)ri.lname3.first_seen),
												4		=> 	IF(ri.lname4.first_seen=0,'',(STRING8)ri.lname4.first_seen),
												''),
						 le.altearly_date3);
									
	SELF.altlast_count := IF(i=1,(INTEGER)(self.altlast<>'') + (INTEGER)(self.altlast2<>'') + (INTEGER)(self.altlast3<>''),
						le.altlast_count);

	self.lastssnmatch := IF(i=1,ri.lname1.lname=le.lname AND ri.lname1.first_seen < history_date or 
						   ri.lname2.lname=le.lname AND ri.lname2.first_seen < history_date or 
						   ri.lname3.lname=le.lname AND ri.lname3.first_seen < history_date or 
						   ri.lname4.lname=le.lname AND ri.lname4.first_seen < history_date,
					    le.lastssnmatch);
	self.lastssnmatch2 := IF(i=1,g(LnameScore(ri.lname1.lname, le.lname)) AND ri.lname1.first_seen < history_date or
						    g(LnameScore(ri.lname2.lname, le.lname)) AND ri.lname2.first_seen < history_date or
						    g(LnameScore(ri.lname3.lname, le.lname)) AND ri.lname3.first_seen < history_date or
						    g(LnameScore(ri.lname4.lname, le.lname)) AND ri.lname4.first_seen < history_date,
						le.lastssnmatch2);
	self.firstssnmatch := IF(i=1,g(FnameScore(ri.lname1.fname, le.fname)) AND ri.lname1.first_seen < history_date or
						    g(FnameScore(ri.lname2.fname, le.fname)) AND ri.lname2.first_seen < history_date or
						    g(FnameScore(ri.lname3.fname, le.fname)) AND ri.lname3.first_seen < history_date or
						    g(FnameScore(ri.lname4.fname, le.fname)) AND ri.lname4.first_seen < history_date,
						le.firstssnmatch);
	
	// Death and Bankrupt are both nonglb
	self.bansFlag := IF(i=1,MAP(ri.isBankrupt AND ((string)ri.dt_first_bankrupt < full_history_date) => '1',
						   // a 2 would be for a full name and address match
						   le.ssn='' OR le.lname='' OR le.prim_name='' => '3',	// does not appear that st. cloud will return a 3 anymore
						   '0'),
					le.bansFlag);
	self.bansdatefiled := IF(i=1 and self.bansflag='1', (string)ri.dt_first_bankrupt, le.bansdatefiled);
	self.decsflag := IF(i=1,MAP(isOver => '0', ri.isDeceased AND ((string)ri.dt_first_deceased < full_history_date)  => '1',
						   self.socsvalflag IN ['2','3']/* OR length(le.dob) < 6 OR le.dob='' OR (INTEGER)le.dob=0*/ => '2',
						   '0'),
					le.decsflag);
	self.deceasedDate := ri.dt_first_deceased;				
	self.socllowissue := IF(isOver, '', IF(i=1,TRIM((STRING)ri.official_first_seen,LEFT),le.socllowissue));
	self.soclhighissue := IF(isOver, '', IF(i=1,TRIM((STRING)ri.official_last_seen,LEFT),le.soclhighissue));

	self.socsdobflag := IF(i=1,validate_ssn(le.ssn,le.dob).ssnDobFlag(ri.official_last_seen),le.socsdobflag);
	self.PWsocsdobflag := IF(i=1,MAP(self.socsdobflag = '3' or self.PWsocsvalflag = '6' OR SELF.SOCSDOBFLAG='2' => '2',
							   self.socsdobflag = '1' => '1',
							   self.socsdobflag = '0' => '0',
							   '0'),
						le.pwsocsdobflag);
	self.socsdidCount := IF(i=1,ri.DidCount,le.socsdidcount);
	self.addrs_per_ssn := IF(i=1, ri.addr_ct, le.addrs_per_ssn); 
	self.adls_per_ssn_created_6months := IF(i=1, ri.DidCount_c6, le.adls_per_ssn_created_6months);
	self.addrs_per_ssn_created_6months := IF(i=1, ri.addr_ct_c6, le.addrs_per_ssn_created_6months);

	
	// added these for dl validation stuff
	self.dlMatch := IF(i=2,g(LnameScore(ri.lname1.lname,le.lname)) AND ri.lname1.first_seen < history_date or 
					   g(LnameScore(ri.lname2.lname,le.lname)) AND ri.lname2.first_seen < history_date or 
					   g(LnameScore(ri.lname3.lname,le.lname)) AND ri.lname3.first_seen < history_date or 
					   g(LnameScore(ri.lname4.lname,le.lname)) AND ri.lname4.first_seen < history_date,
			         le.dlMatch);
	vdl := Validate_SSN(le.dl_number[1..9],'');			    
	self.dlsocsvalflag := IF(i=2,MAP(isOver => '0', le.dl_number[1..9]='' => '6',
							   (ri.ssn<>'' and (~ri.isValidFormat OR ~ri.isSequenceValid)) or vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
							   le.dob<> '' and (UNSIGNED3)ri.official_last_seen - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   (UNSIGNED3)ri.official_last_seen <> 0 and (INTEGER)(ut.GetDate[1..6]) - (UNSIGNED3)ri.official_last_seen < 700 => '4',
							   // not sure what to do for 3 or 2
							   '0'),
						le.dlsocsvalflag);
	dlsocsdob := validate_ssn(le.dl_number[1..9],le.dob).ssnDobFlag(ri.official_last_seen);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob = '3' or self.dlsocsvalflag = '6' OR dlsocsdob='2' => '2',
							   dlsocsdob = '1' => '1',
							   dlsocsdob = '0' => '0',
							   '0'),
						le.dlsocsdobflag);

	self := le;
END;
ENDMACRO;

MAC_ssnTable_transform (get_ssnTable, risk_indicators.key_ssn_table_v2);
MAC_ssnTable_transform (get_ssnTable_FCRA, risk_indicators.key_ssn_table_FCRA_v2);

got_SSNTable :=
 if (isFCRA, join (sortedGood, risk_indicators.key_ssn_table_FCRA_v2,
                   left.ssn!='' and keyed(left.ssn=right.ssn) AND (RIGHT.header_first_seen < history_date),  // check date
                   get_ssnTable_FCRA(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500)),
					   join (sortedGood,risk_indicators.key_ssn_table_v2,
							left.ssn!='' and keyed(left.ssn=right.ssn) AND (RIGHT.header_first_seen < history_date),
							get_ssnTable(left,right,1),left outer, ATMOST(keyed(left.ssn=right.ssn),500)));
got_SSNTableDL :=
 if (isFCRA, join (got_SSNTable, risk_indicators.key_ssn_table_FCRA_v2,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn) AND (RIGHT.header_first_seen < history_date),
                   get_ssnTable_FCRA(left,right,2),left outer, ATMOST( keyed(left.dl_number[1..9]=right.ssn),500)),
             join (got_SSNTable, risk_indicators.key_ssn_table_v2,
                   left.dl_number!='' and keyed(left.dl_number[1..9]=right.ssn) AND (RIGHT.header_first_seen < history_date),
                   get_ssnTable(left,right,2),left outer, ATMOST(keyed(left.dl_number[1..9]=right.ssn),500)));	
			    
			    
// do velocity stuff here, currently using current results for these fields
// gotSSNVelocity := getSSNVelocityHist(got_SSNTableDL, history_date);
// wSSNVelocity := if(history_date = 999999, got_SSNTableDL, gotSSNVelocity);			    
			    
			    
										
layout_output get_ssnMap (layout_output le, doxie.Key_SSN_Map ri, INTEGER i) := transform

	isOver := suppress.check_ssnOver(le.did, le.ssn);
  
  // new ssn-issue data have '20990101' for the current date intervals
  r_end := (UNSIGNED3) (ri.end_date[1..6]);
  end_yyyymm := IF (r_end = 209901, 0, r_end); 

	self.socsvalflag := IF(i=1, IF(le.socsvalflag='0' and ri.ssn5='','1',le.socsvalflag),
					   le.socsvalflag);
	self.PWsocsvalflag := IF(i=1,MAP(le.PWsocsvalflag='0' and ri.ssn5='' => '1',
							   le.PWsocsvalflag='0' and le.dob<> '' and end_yyyymm - (UNSIGNED3)(le.dob[1..6]) > 1800 => '5',
							   le.PWsocsvalflag='0' and end_yyyymm <> 0 and (INTEGER)(ut.GetDate[1..6]) - end_yyyymm < 700 => '4',
							   le.PWsocsvalflag),
						le.PWsocsvalflag);
						
	self.socllowissue  := IF (isOver, '', IF(i=1, ri.start_date, le.socllowissue));
	self.soclhighissue := IF (isOver, '', IF(i=1, IF ((unsigned)ri.end_date in [0, 20990101, 20991231], '', ri.end_date), le.soclhighissue));
	SELF.soclstate := IF(isOver, '', IF(i=1,Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state)),le.soclstate));
	
	self.socsdobflag := IF(i=1,validate_ssn(le.ssn,le.dob).ssnDobFlag (end_yyyymm),le.socsdobflag);
	self.PWsocsdobflag := IF(i=1,MAP(self.socsdobflag = '3' or self.PWsocsvalflag = '6' OR SELF.SOCSDOBFLAG='2' => '2',
							   self.socsdobflag = '1' => '1',
							   self.socsdobflag = '0' => '0',
							   '0'),
						le.pwsocsdobflag);
						
	// needed for dl validation stuff
	self.dlsocsvalflag := IF(i=2,IF(le.dlsocsvalflag='0' and ri.ssn5='','1',le.dlsocsvalflag),
						le.dlsocsvalflag);
	dlsocsdob := validate_ssn(le.dl_number[1..9],le.dob).ssnDobFlag(end_yyyymm);
	self.dlsocsdobflag := IF(i=2,MAP(dlsocsdob='3' or self.dlsocsvalflag='6' or dlsocsdob='2' => '2',
							   dlsocsdob='1' => '1',
							   dlsocsdob='0' => '0',
							   '0'),
						le.dlsocsdobflag);
	
	SELF := le;
END;

// JRP 07/07/2008 - BOM - Bug 31747 - Changed from using ATMOST(1) to KEEP(1) to handle cases where we may get bad data from the vendor
//																			 in doxie.Key_SSN_Map.
got_SSNMap := join(got_SSNTableDL, doxie.Key_SSN_Map,
					(left.ssn!='') and 
          keyed (left.ssn[1..5]=right.ssn5) AND
          keyed (left.ssn[6..9] between Right.start_serial AND Right.end_serial) AND
					// check date
					((unsigned3)(RIGHT.start_date[1..6]) < history_date),
					get_ssnMap(left,right, 1),
          LEFT OUTER, KEEP (1));
					

got_SSNMapDL := join(got_SSNMap, doxie.Key_SSN_Map,
					(left.dl_number!='') and
          keyed(left.dl_number[1..5]=right.ssn5) AND
          //TODO: not clear if check for start/end_serial for DL
					// check date
					((unsigned3)(RIGHT.start_date[1..6]) < history_date),
					get_ssnMap(left,right, 2),
          LEFT OUTER, KEEP (1));
// JRP 07/07/2008 - EOM

betterAddresses := Grade_Addresses_Function(got_SSNMapDL);

noNearDups := JOIN(got_SSNMapDL, betterAddresses,
												LEFT.seq = RIGHT.indata.seq 
												AND LEFT.chronoprim_range=RIGHT.prim_range
												AND LEFT.chronoprim_name=RIGHT.prim_name 
												AND LEFT.chronosec_range=RIGHT.sec_range
												AND LEFT.chronozip = RIGHT.zip,
												TRANSFORM(Layout_Output, SELF := LEFT), LOOKUP);

												
sortedBest := group(sort(IF(suppressNearDups, noNearDups, got_SSNMapDL), seq, -dt_last_seen, -chronodate_first, chronolast, chronofirst, chronoprim_name), seq);

layout_output countadd(layout_output l,layout_output r) := transform
	SELF.header_footprint := l.header_footprint + r.header_footprint;
	
	source_seen := r.src='XX' OR Stringlib.StringFind(l.sources,r.src+',',1)>0;
	firstnamesource_seen := r.src='XX' OR Stringlib.StringFind(l.firstnamesources,r.src+',',1)>0;
	lastnamesource_seen := r.src='XX' OR Stringlib.StringFind(l.lastnamesources,r.src+',',1)>0;
	addrsource_seen := r.src='XX' OR Stringlib.StringFind(l.addrsources,r.src+',',1)>0;
	socssource_seen := r.src='XX' OR Stringlib.StringFind(l.socssources,r.src+',',1)>0;
	
	hphonesource_seen := r.src='XX' OR Stringlib.StringFind(l.hphonesources,r.src+',',1)>0;
	wphonesource_seen := r.src='XX' OR Stringlib.StringFind(l.wphonesources,r.src+',',1)>0;
	cmpysource_seen := r.src='XX' OR Stringlib.StringFind(l.cmpysources,r.src+',',1)>0;
	dobsource_seen := r.src='XX' OR Stringlib.StringFind(l.dobsources,r.src+',',1)>0;
	
	SELF.sources := IF(source_seen,l.sources,TRIM(l.sources)+r.src+',');
	SELF.firstnamesources := IF(firstnamesource_seen OR r.firstcount=0,l.firstnamesources,TRIM(l.firstnamesources)+r.src+',');
	SELF.lastnamesources := IF(lastnamesource_seen OR r.lastcount=0,l.lastnamesources,TRIM(l.lastnamesources)+r.src+',');
	SELF.addrsources := IF(addrsource_seen OR r.addrcount=0,l.addrsources,TRIM(l.addrsources)+r.src+',');
	SELF.socssources := IF(socssource_seen OR r.socscount=0,l.socssources,TRIM(l.socssources)+r.src+',');
	SELF.hphonesources := IF(hphonesource_seen OR r.hphonecount=0,l.hphonesources,TRIM(l.hphonesources)+r.src+',');
	SELF.wphonesources := IF(wphonesource_seen OR r.wphonecount=0,l.wphonesources,TRIM(l.wphonesources)+r.src+',');
	SELF.cmpysources := IF(cmpysource_seen OR r.cmpycount=0,l.cmpysources,TRIM(l.cmpysources)+r.src+',');
	SELF.dobsources := IF(dobsource_seen OR r.dobcount=0,l.dobsources,TRIM(l.dobsources)+r.src+',');
	
	SELF.numsource := l.numsource + IF(source_seen,0,1);
	
	self.num_nonderogs := l.num_nonderogs + IF(source_seen,0,1);
	self.num_nonderogs30 := l.num_nonderogs30 + IF(source_seen,0,1);
	self.num_nonderogs90 := l.num_nonderogs90 + IF(source_seen,0,1);
	self.num_nonderogs180 := l.num_nonderogs180 + IF(source_seen,0,1);
	self.num_nonderogs12 := l.num_nonderogs12 + IF(source_seen,0,1);
	self.num_nonderogs24 := l.num_nonderogs24 + IF(source_seen,0,1);
	self.num_nonderogs36 := l.num_nonderogs36 + IF(source_seen,0,1);
	self.num_nonderogs60 := l.num_nonderogs60 + IF(source_seen,0,1);
	
	
	chooser(BOOLEAN seen, INTEGER i, INTEGER x) := IF(seen,i,i+x);

	self.firstcount := chooser(firstnamesource_seen, l.firstcount, r.firstcount);
	self.lastcount := chooser(lastnamesource_seen, l.lastcount, r.lastcount);
	self.addrcount := chooser(addrsource_seen, l.addrcount, r.addrcount);
	self.socscount := chooser(socssource_seen, l.socscount, r.socscount);
	
	self.hphonecount := chooser(hphonesource_seen, l.hphonecount, r.hphonecount);
	self.wphonecount := chooser(wphonesource_seen, l.wphonecount, r.wphonecount);
	self.cmpycount := chooser(cmpysource_seen, l.cmpycount, r.cmpycount);
	self.dobcount := chooser(dobsource_seen, l.dobcount, r.dobcount);
		
	self.eqfsfirstcount := l.eqfsfirstcount OR r.eqfsfirstcount;
	self.eqfslastcount := l.eqfslastcount OR r.eqfslastcount;
	self.eqfsaddrcount := l.eqfsaddrcount OR r.eqfsaddrcount;
	self.eqfssocscount := l.eqfssocscount OR r.eqfssocscount;
	
	self.tufirstcount := l.tufirstcount OR r.tufirstcount;
	self.tulastcount := l.tulastcount OR r.tulastcount;
	self.tuaddrcount := l.tuaddrcount OR r.tuaddrcount;
	self.tusocscount := l.tusocscount OR r.tusocscount;
	
	self.dlfirstcount := l.dlfirstcount OR r.dlfirstcount;
	self.dllastcount := l.dllastcount OR r.dllastcount;
	self.dladdrcount := l.dladdrcount OR r.dladdrcount;
	self.dlsocscount := l.dlsocscount OR r.dlsocscount;
	
	self.emfirstcount := l.emfirstcount OR r.emfirstcount;
	self.emlastcount := l.emlastcount OR r.emlastcount;
	self.emaddrcount := l.emaddrcount OR r.emaddrcount;
	self.emsocscount := l.emsocscount OR r.emsocscount;
	
	self.bkfirstcount := l.bkfirstcount OR r.bkfirstcount;
	self.bklastcount := l.bklastcount OR r.bklastcount;
	self.bkaddrcount := l.bkaddrcount OR r.bkaddrcount;
	self.bksocscount := l.bksocscount OR r.bksocscount;
	
	SELF.adl_eqfs_first_seen := ut.Min2(l.adl_eqfs_first_seen,r.adl_eqfs_first_seen);
	SELF.adl_eqfs_last_seen := ut.max2(l.adl_eqfs_last_seen,r.adl_eqfs_last_seen);
	
	// new dev shell fields
	self.EQ_count := l.eq_count + r.eq_count;
	self.TU_count := l.tu_count + r.tu_count;
	self.DL_count := l.dl_count + r.dl_count;
	self.PR_count := l.pr_count + r.pr_count;
	self.V_count := l.v_count + r.v_count;
	self.EM_count := l.em_count + r.em_count;
	self.W_count := l.w_count + r.w_count;
	self.adl_TU_first_seen := ut.Min2(l.adl_tu_first_seen, r.adl_tu_first_seen);
	self.adl_TU_last_seen := ut.Max2(l.adl_tu_last_seen, r.adl_tu_last_seen);
	self.adl_DL_first_seen := ut.Min2(l.adl_dl_first_seen, r.adl_dl_first_seen);
	self.adl_DL_last_seen := ut.Max2(l.adl_dl_last_seen, r.adl_dl_last_seen);
	self.adl_PR_first_seen := ut.Min2(l.adl_pr_first_seen, r.adl_pr_first_seen);
	self.adl_PR_last_seen := ut.Max2(l.adl_pr_last_seen, r.adl_pr_last_seen);
	self.adl_V_first_seen := ut.Min2(l.adl_v_first_seen, r.adl_v_first_seen);
	self.adl_V_last_seen := ut.Max2(l.adl_v_last_seen, r.adl_v_last_seen);
	self.adl_EM_first_seen := ut.Min2(l.adl_em_first_seen, r.adl_em_first_seen);
	self.adl_EM_last_seen := ut.Max2(l.adl_em_last_seen, r.adl_em_last_seen);
	self.adl_W_first_seen := ut.Min2(l.adl_w_first_seen, r.adl_w_first_seen);
	self.adl_W_last_seen := ut.Max2(l.adl_w_last_seen, r.adl_w_last_seen);

	SELF.adl_other_first_seen := ut.Min2(l.adl_other_first_seen,r.adl_other_first_seen);
	SELF.adl_other_last_seen := ut.max2(l.adl_other_last_seen,r.adl_other_last_seen);
	
	howmany := MAP(l.chronoprim_name='' OR (l.chronoprim_name=r.chronoprim_name and l.chronoprim_range=r.chronoprim_range)  => 1,
				l.chronoprim_name2='' OR (l.chronoprim_name2=r.chronoprim_name and l.chronoprim_range2=r.chronoprim_range) => 2,
				l.chronoprim_name3='' OR (l.chronoprim_name3=r.chronoprim_name and l.chronoprim_range3=r.chronoprim_range) => 3,
				4);

	// chronology that keeps track of which sources
	

	chrono_source_seen := IF(howmany=1,r.src='XX' OR Stringlib.StringFind(l.chrono_sources,r.src+',',1)>0,false);
	SELF.chrono_sources := IF(howmany<>1 OR chrono_source_seen, l.chrono_sources, TRIM(l.chrono_sources)+r.src+',');
	SELF.chrono_addrcount := IF(howmany<>1 OR chrono_source_seen,l.chrono_addrcount,l.chrono_addrcount+1);
	SELF.chrono_eqfsaddrcount := IF(howmany<>1,l.chrono_eqfsaddrcount,l.chrono_eqfsaddrcount OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount := IF(howmany<>1,l.chrono_dladdrcount,l.chrono_dladdrcount OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount := IF(howmany<>1,l.chrono_emaddrcount,l.chrono_emaddrcount OR r.chrono_emaddrcount);

	self.chronofirst := IF(howmany=1,r.chronofirst,l.chronofirst);
	self.chronolast := IF(howmany=1,r.chronolast,l.chronolast);
	self.chronoprim_range := IF(howmany=1,r.chronoprim_range,l.chronoprim_range);
	self.chronopredir := IF(howmany=1,r.chronopredir,l.chronopredir);
	self.chronoprim_name := IF(howmany=1,r.chronoprim_name,l.chronoprim_name);
	self.chronosuffix := IF(howmany=1,r.chronosuffix,l.chronosuffix);
	self.chronopostdir := IF(howmany=1,r.chronopostdir,l.chronopostdir);
	self.chronounit_desig := IF(howmany=1,r.chronounit_desig,l.chronounit_desig);
	self.chronosec_range := IF(howmany=1,r.chronosec_range,l.chronosec_range);
	self.chronocity := IF(howmany=1,r.chronocity,l.chronocity);
	self.chronostate := IF(howmany=1,r.chronostate,l.chronostate);
	self.chronozip := IF(howmany=1,r.chronozip,l.chronozip);
	self.chronozip4 := IF(howmany=1,r.chronozip4,l.chronozip4);
	self.chronocounty := IF(howmany=1,r.chronocounty,l.chronocounty);
	self.chronogeo_blk := IF(howmany=1,r.chronogeo_blk,l.chronogeo_blk);
	self.chronodate_first := IF(howmany=1,ut.Min2(l.chronodate_first,r.chronodate_first),l.chronodate_first);
	self.chronodate_last := IF(howmany=1,ut.Max2(l.chronodate_last,r.chronodate_last),l.chronodate_last);
	self.chronoaddrscore := IF(howmany=1,r.chronoaddrscore,l.chronoaddrscore);

	chrono_source_seen2 := IF(howmany=2,r.src='XX' OR Stringlib.StringFind(l.chrono_sources2,r.src+',',1)>0,false);
	SELF.chrono_sources2 := IF(howmany<>2 OR chrono_source_seen2, l.chrono_sources2, TRIM(l.chrono_sources2)+r.src+',');
	SELF.chrono_addrcount2 := IF(howmany<>2 OR chrono_source_seen2,l.chrono_addrcount2,l.chrono_addrcount2+1);
	SELF.chrono_eqfsaddrcount2 := IF(howmany<>2,l.chrono_eqfsaddrcount2,l.chrono_eqfsaddrcount2 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount2 := IF(howmany<>2,l.chrono_dladdrcount2,l.chrono_dladdrcount2 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount2 := IF(howmany<>2,l.chrono_emaddrcount2,l.chrono_emaddrcount2 OR r.chrono_emaddrcount);

	self.chronofirst2 := IF(howmany=2,r.chronofirst,l.chronofirst2);
	self.chronolast2 := IF(howmany=2,r.chronolast,l.chronolast2);
	self.chronoprim_range2 := IF(howmany=2,r.chronoprim_range,l.chronoprim_range2);
	self.chronopredir2 := IF(howmany=2,r.chronopredir,l.chronopredir2);
	self.chronoprim_name2 := IF(howmany=2,r.chronoprim_name,l.chronoprim_name2);
	self.chronosuffix2 := IF(howmany=2,r.chronosuffix,l.chronosuffix2);
	self.chronopostdir2 := IF(howmany=2,r.chronopostdir,l.chronopostdir2);
	self.chronounit_desig2 := IF(howmany=2,r.chronounit_desig,l.chronounit_desig2);
	self.chronosec_range2 := IF(howmany=2,r.chronosec_range,l.chronosec_range2);
	self.chronocity2 := IF(howmany=2,r.chronocity,l.chronocity2);
	self.chronostate2 := IF(howmany=2,r.chronostate,l.chronostate2);
	self.chronozip2 := IF(howmany=2,r.chronozip,l.chronozip2);
	self.chronozip4_2 := IF(howmany=2,r.chronozip4,l.chronozip4_2);
	self.chronocounty2 := IF(howmany=2,r.chronocounty,l.chronocounty2);
	self.chronogeo_blk2 := IF(howmany=2,r.chronogeo_blk,l.chronogeo_blk2);
	self.chronodate_first2 := IF(howmany=2,ut.Min2(l.chronodate_first2,r.chronodate_first),l.chronodate_first2);
	self.chronodate_last2 := IF(howmany=2,ut.Max2(l.chronodate_last2,r.chronodate_last),l.chronodate_last2);
	self.chronoaddrscore2 := IF(howmany=2,r.chronoaddrscore,l.chronoaddrscore2);

	chrono_source_seen3 := IF(howmany=3,r.src='XX' OR Stringlib.StringFind(l.chrono_sources3,r.src+',',1)>0,false);
	SELF.chrono_sources3 := IF(howmany<>3 OR chrono_source_seen3, l.chrono_sources3, TRIM(l.chrono_sources3)+r.src+',');
	SELF.chrono_addrcount3 := IF(howmany<>3 OR chrono_source_seen3,l.chrono_addrcount3,l.chrono_addrcount3+1);
	SELF.chrono_eqfsaddrcount3 := IF(howmany<>3,l.chrono_eqfsaddrcount3,l.chrono_eqfsaddrcount3 OR r.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount3 := IF(howmany<>3,l.chrono_dladdrcount3,l.chrono_dladdrcount3 OR r.chrono_dladdrcount);
	SELF.chrono_emaddrcount3 := IF(howmany<>3,l.chrono_emaddrcount3,l.chrono_emaddrcount3 OR r.chrono_emaddrcount);

	self.chronofirst3 := IF(howmany=3,r.chronofirst,l.chronofirst3);
	self.chronolast3 := IF(howmany=3,r.chronolast,l.chronolast3);
	self.chronoprim_range3 := IF(howmany=3,r.chronoprim_range,l.chronoprim_range3);
	self.chronopredir3 := IF(howmany=3,r.chronopredir,l.chronopredir3);
	self.chronoprim_name3 := IF(howmany=3,r.chronoprim_name,l.chronoprim_name3);
	self.chronosuffix3 := IF(howmany=3,r.chronosuffix,l.chronosuffix3);
	self.chronopostdir3 := IF(howmany=3,r.chronopostdir,l.chronopostdir3);
	self.chronounit_desig3 := IF(howmany=3,r.chronounit_desig,l.chronounit_desig3);
	self.chronosec_range3 := IF(howmany=3,r.chronosec_range,l.chronosec_range3);
	self.chronocity3 := IF(howmany=3,r.chronocity,l.chronocity3);
	self.chronostate3 := IF(howmany=3,r.chronostate,l.chronostate3);
	self.chronozip3 := IF(howmany=3,r.chronozip,l.chronozip3);
	self.chronozip4_3 := IF(howmany=3,r.chronozip4,l.chronozip4_3);
	self.chronocounty3 := IF(howmany=3,r.chronocounty,l.chronocounty3);
	self.chronogeo_blk3 := IF(howmany=3,r.chronogeo_blk,l.chronogeo_blk3);
	self.chronodate_first3 := IF(howmany=3,ut.Min2(l.chronodate_first3,r.chronodate_first),l.chronodate_first3);
	self.chronodate_last3 := IF(howmany=3,ut.Max2(l.chronodate_last3,r.chronodate_last),l.chronodate_last3);
	self.chronoaddrscore3 := IF(howmany=3,r.chronoaddrscore,l.chronoaddrscore3);

	ssn_by_score := tscore(l.socsscore)>=tscore(r.socsscore);

	// ssn_lpicker := MAP(l.socsvalid='G' AND r.socsvalid='G' => ssn_by_score,
					// l.socsvalid='G' AND ~(l.header_footprint < 4)		=> true,
					// r.socsvalid='G' AND ~(l.header_footprint < 4)	=> false,
					// ssn_by_score);
	
	self.versocs := IF(ssn_by_score,l.versocs,r.versocs);
	self.socsscore := IF(ssn_by_score,l.socsscore,r.socsscore);
	self.socsvalid := IF(ssn_by_score,l.socsvalid,r.socsvalid);
	
	addr_lpicker := tscore(l.addrscore)>=tscore(r.addrscore) or (l.verprim_name<>'' and r.addrcount=0);
	
	self.verprim_range := IF(addr_lpicker,l.verprim_range,r.verprim_range);
	self.verpredir := IF(addr_lpicker,l.verpredir,r.verpredir);
	self.verprim_name := IF(addr_lpicker,l.verprim_name,r.verprim_name);
	self.versuffix := IF(addr_lpicker,l.versuffix,r.versuffix);
	self.verpostdir := IF(addr_lpicker,l.verpostdir,r.verpostdir);
	self.verunit_desig := IF(addr_lpicker,l.verunit_desig,r.verunit_desig);
	self.versec_range := IF(addr_lpicker,l.versec_range,r.versec_range);
	self.vercity := IF(addr_lpicker,l.vercity,r.vercity);
	self.verstate := IF(addr_lpicker,l.verstate,r.verstate);
	self.verzip := IF(addr_lpicker,l.verzip,r.verzip);
	self.vercounty := IF(addr_lpicker,l.vercounty,r.vercounty);
	self.vergeo_blk := IF(addr_lpicker,l.vergeo_blk,r.vergeo_blk);
	
	self.addrscore := IF(addr_lpicker,l.addrscore,r.addrscore);
	
	self.addrmultiple := l.prim_name<>'' AND r.prim_name<>'';
	
	self.verlast := IF(tscore(l.lastscore)>=tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.verlast,r.verlast);
	self.lastscore := IF(tscore(l.lastscore)>=tscore(r.lastscore) or (l.verlast<>'' and r.lastcount=0),l.lastscore,r.lastscore);
	
	self.verfirst := IF(tscore(l.firstscore)>=tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.verfirst,r.verfirst);
	self.firstscore := IF(tscore(l.firstscore)>=tscore(r.firstscore) or (l.verfirst<>'' and r.firstcount=0),l.firstscore,r.firstscore);
	
	self.verdob := IF((tscore(l.dobscore)>=tscore(r.dobscore) and (integer)l.verdob<>0) or ((integer)l.verdob<>0 and r.dobcount=0),l.verdob,r.verdob);
	self.dobscore := IF((tscore(l.dobscore)>=tscore(r.dobscore) and (integer)l.verdob<>0) or ((integer)l.verdob<>0 and r.dobcount=0),l.dobscore,r.dobscore);
	
	self.verhphone := IF(tscore(l.hphonescore)>=tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.verhphone,r.verhphone);
	self.hphonescore := IF(tscore(l.hphonescore)>=tscore(r.hphonescore) or (l.verhphone<>'' and r.hphonecount=0),l.hphonescore,r.hphonescore);
	
	self.verwphone := IF(tscore(l.wphonescore)>=tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.verwphone,r.verwphone);
	self.wphonescore := IF(tscore(l.wphonescore)>=tscore(r.wphonescore) or (l.verwphone<>'' and r.wphonecount=0),l.wphonescore,r.wphonescore);
	
	self.verdate_first := ut.Min2(l.verdate_first,r.verdate_first);
	self := l;
END;


rollbestcount := rollup(sortedbest,true,countadd(left,right));


// pluck the deceased value from ssn_table already done and send that through to ssnCodes function			
codes_in := ungroup( project(rollbestcount, transform(RiskWise.layouts.layout_ssn_in,
									self.deceased := left.decsflag='1',  
									self := left)) );
									
socl := risk_indicators.getSSNCodes(codes_in, history_date);
			
layout_output add_ssncodes(got_SSNMap le, socl rt) := transform
	self.inputsocscharflag := map(le.ssn='' => '6', // ssn empty
						     rt.socscode in ['0','110'] and rt.dobcode='60' => '5', // valid, but issued after 18th birthday
							rt.socscode in ['0','110'] and (integer)ut.getdate[1..4] - (integer)rt.highissue[1..4] <= 7 => '4',  // valid, but issued in the last 7 years
							rt.socscode in ['14','15','104','105','106','109','180','181','200','201'] => '1', // invalid
							rt.socscode in ['100','103','107','108'] => '2', // invalid, not issued
							rt.socscode = '12' => '3', // invalid; pocket book type
							'0');  // valid
	self.inputsocscode := rt.socscode; // save the raw socs code for use elsewhere
	self := le;
end;
with_socs_codes := join(rollbestcount, socl, left.seq=right.seq, add_ssncodes(left,right), left outer, lookup);						
					

// check to see if correction record or only 1 element verified then revert back to no DID found
layout_output removeHeader(layout_output le) := TRANSFORM
	isOnly1 := ((INTEGER)(BOOLEAN)le.firstcount+(INTEGER)(BOOLEAN)le.lastcount+(INTEGER)(BOOLEAN)le.addrcount+(INTEGER)(BOOLEAN)le.socscount+(INTEGER)(BOOLEAN)le.dobcount) = 1;
				
	blankOut := isOnly1 and StringLib.StringFind(le.src,'CO',1)=0;
	
	self.did := if(blankOut, 0, le.did);

	SELF.header_footprint := if(blankOut, 0, le.header_footprint);
		
	SELF.trueDID := if(blankOut, false, le.trueDID);
	
	self.src := if(blankOut, '', le.src);

	self.dt_last_seen := if(blankOut, 0, le.dt_last_seen);			 
	self.firstcount := if(blankOut, 0, le.firstcount);
	self.lastcount := if(blankOut, 0, le.lastcount);
	self.addrcount := if(blankOut, 0, le.addrcount);
	self.socscount := if(blankOut, 0, le.socscount);
	self.hphonecount := if(blankOut, 0, le.hphonecount);
	self.wphonecount := if(blankOut, 0, le.wphonecount);
	self.cmpycount := if(blankOut, 0, le.cmpycount);
	self.dobcount := if(blankOut, 0, le.dobcount);
	
	self.eqfsfirstcount := if(blankOut, false, le.eqfsfirstcount);
	self.eqfslastcount := if(blankOut, false, le.eqfslastcount);
	self.eqfsaddrcount := if(blankOut, false, le.eqfsaddrcount);
	self.eqfssocscount := if(blankOut, false, le.eqfssocscount);

	self.tufirstcount := if(blankOut, false, le.tufirstcount);
	self.tulastcount := if(blankOut, false, le.tulastcount);
	self.tuaddrcount := if(blankOut, false, le.tuaddrcount);
	self.tusocscount := if(blankOut, false, le.tusocscount);

	self.dlfirstcount := if(blankOut, false, le.dlfirstcount);
	self.dllastcount := if(blankOut, false, le.dllastcount);
	self.dladdrcount := if(blankOut, false, le.dladdrcount);
	self.dlsocscount := if(blankOut, false, le.dlsocscount);

	self.emfirstcount := if(blankOut, false, le.emfirstcount);
	self.emlastcount := if(blankOut, false, le.emlastcount);
	self.emaddrcount := if(blankOut, false, le.emaddrcount);
	self.emsocscount := if(blankOut, false, le.emsocscount);

	self.bkfirstcount := if(blankOut, false, le.bkfirstcount);
	self.bklastcount := if(blankOut, false, le.bklastcount);
	self.bkaddrcount := if(blankOut, false, le.bkaddrcount);
	self.bksocscount := if(blankOut, false, le.bksocscount);

	SELF.adl_eqfs_first_seen := if(blankOut, 0, le.adl_eqfs_first_seen); 
	SELF.adl_eqfs_last_seen := if(blankOut, 0, le.adl_eqfs_last_seen);
	SELF.adl_other_first_seen := if(blankOut, 0, le.adl_other_first_seen);
	SELF.adl_other_last_seen := if(blankOut, 0, le.adl_other_last_seen);

	SELF.chrono_sources := if(blankOut, '', le.chrono_sources);
	SELF.chrono_addrcount := if(blankOut, 0, le.chrono_addrcount);
	SELF.chrono_eqfsaddrcount := if(blankOut, false, le.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount := if(blankOut, false, le.chrono_dladdrcount);
	SELF.chrono_emaddrcount := if(blankOut, false, le.chrono_emaddrcount);

	self.chronofirst := if(blankOut, '', le.chronofirst);
	self.chronolast := if(blankOut, '', le.chronolast);
	self.chronoprim_range := if(blankOut, '', le.chronoprim_range);
	self.chronopredir := if(blankOut, '', le.chronopredir);
	self.chronoprim_name := if(blankOut, '', le.chronoprim_name);
	self.chronosuffix := if(blankOut, '', le.chronosuffix);
	self.chronopostdir := if(blankOut, '', le.chronopostdir);
	self.chronounit_desig := if(blankOut, '', le.chronounit_desig);
	self.chronosec_range := if(blankOut, '', le.chronosec_range);
	self.chronocity := if(blankOut, '', le.chronocity);
	self.chronostate := if(blankOut, '', le.chronostate);
	self.chronozip := if(blankOut, '', le.chronozip);
	self.chronozip4 := if(blankOut, '', le.chronozip4);
	self.chronocounty := if(blankOut, '', le.chronocounty);
	self.chronogeo_blk := if(blankOut, '', le.chronogeo_blk);
	self.chronodate_first := if(blankOut, 0, le.chronodate_first);
	self.chronodate_last := if(blankOut, 0, le.chronodate_last);
	self.chronoaddrscore := if(blankOut, 0, le.chronoaddrscore);
	
	SELF.chrono_sources2 := if(blankOut, '', le.chrono_sources);
	SELF.chrono_addrcount2 := if(blankOut, 0, le.chrono_addrcount);
	SELF.chrono_eqfsaddrcount2 := if(blankOut, false, le.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount2 := if(blankOut, false, le.chrono_dladdrcount);
	SELF.chrono_emaddrcount2 := if(blankOut, false, le.chrono_emaddrcount);

	self.chronofirst2 := if(blankOut, '', le.chronofirst2);
	self.chronolast2 := if(blankOut, '', le.chronolast2);
	self.chronoprim_range2 := if(blankOut, '', le.chronoprim_range2);
	self.chronopredir2 := if(blankOut, '', le.chronopredir2);
	self.chronoprim_name2 := if(blankOut, '', le.chronoprim_name2);
	self.chronosuffix2 := if(blankOut, '', le.chronosuffix2);
	self.chronopostdir2 := if(blankOut, '', le.chronopostdir2);
	self.chronounit_desig2 := if(blankOut, '', le.chronounit_desig2);
	self.chronosec_range2 := if(blankOut, '', le.chronosec_range2);
	self.chronocity2 := if(blankOut, '', le.chronocity2);
	self.chronostate2 := if(blankOut, '', le.chronostate2);
	self.chronozip2 := if(blankOut, '', le.chronozip2);
	self.chronozip4_2 := if(blankOut, '', le.chronozip4_2);
	self.chronocounty2 := if(blankOut, '', le.chronocounty2);
	self.chronogeo_blk2 := if(blankOut, '', le.chronogeo_blk2);
	self.chronodate_first2 := if(blankOut, 0, le.chronodate_first2);
	self.chronodate_last2 := if(blankOut, 0, le.chronodate_last2);
	self.chronoaddrscore2 := if(blankOut, 0, le.chronoaddrscore2);

	SELF.chrono_sources3 := if(blankOut, '', le.chrono_sources);
	SELF.chrono_addrcount3 := if(blankOut, 0, le.chrono_addrcount);
	SELF.chrono_eqfsaddrcount3 := if(blankOut, false, le.chrono_eqfsaddrcount);
	SELF.chrono_dladdrcount3 := if(blankOut, false, le.chrono_dladdrcount);
	SELF.chrono_emaddrcount3 := if(blankOut, false, le.chrono_emaddrcount);

	self.chronofirst3 := if(blankOut, '', le.chronofirst3);
	self.chronolast3 := if(blankOut, '', le.chronolast3);
	self.chronoprim_range3 := if(blankOut, '', le.chronoprim_range3);
	self.chronopredir3 := if(blankOut, '', le.chronopredir3);
	self.chronoprim_name3 := if(blankOut, '', le.chronoprim_name3);
	self.chronosuffix3 := if(blankOut, '', le.chronosuffix3);
	self.chronopostdir3 := if(blankOut, '', le.chronopostdir3);
	self.chronounit_desig3 := if(blankOut, '', le.chronounit_desig3);
	self.chronosec_range3 := if(blankOut, '', le.chronosec_range3);
	self.chronocity3 := if(blankOut, '', le.chronocity3);
	self.chronostate3 := if(blankOut, '', le.chronostate3);
	self.chronozip3 := if(blankOut, '', le.chronozip3);
	self.chronozip4_3 := if(blankOut, '', le.chronozip4_3);
	self.chronocounty3 := if(blankOut, '', le.chronocounty3);
	self.chronogeo_blk3 := if(blankOut, '', le.chronogeo_blk3);
	self.chronodate_first3 := if(blankOut, 0, le.chronodate_first3);
	self.chronodate_last3 := if(blankOut, 0, le.chronodate_last3);
	self.chronoaddrscore3 := if(blankOut, 0, le.chronoaddrscore3);
	
	self.socsscore := if(blankOut, 255, le.socsscore);
	self.versocs := if(blankOut, '', le.versocs);		
	self.socsvalid := if(blankOut, '', le.socsvalid);
	
	//self.ssn := if(length(trim(le.ssn)) = 4 and socsmatch, ssn2use, le.ssn);
	
	// try recent addresses
	self.addrscore := if(blankOut, 255, le.addrscore);
	self.addrmultiple := if(blankOut, false, le.addrmultiple);
	
	self.verprim_range := if(blankOut, '', le.verprim_range);
	self.verpredir := if(blankOut, '', le.verpredir);
	self.verprim_name := if(blankOut, '', le.verprim_name);
	self.versuffix := if(blankOut, '', le.versuffix);
	self.verpostdir := if(blankOut, '', le.verpostdir);
	self.verunit_desig := if(blankOut, '', le.verunit_desig);
	self.versec_range := if(blankOut, '', le.versec_range);
	self.vercity := if(blankOut, '', le.vercity);
	self.verstate := if(blankOut, '', le.verstate);
	self.verzip := if(blankOut, '', le.verzip);
	self.vercounty := if(blankOut, '', le.vercounty);
	self.vergeo_blk := if(blankOut, '', le.vergeo_blk);
	SELF.verdate_last := if(blankOut, 0, le.verdate_last);
	SELF.verdate_first := if(blankOut, 0, le.verdate_first);
	
	self.lastscore := if(blankOut, 255, le.lastscore);
	self.verlast := if(blankOut, '', le.verlast);

	self.firstscore := if(blankOut, 255, le.firstscore);
	self.verfirst := if(blankOut, '', le.verfirst);
	
	self.dobscore := if(blankOut, 255, le.dobscore);
	self.verdob := if(blankOut, '', le.verdob);
	
	self.hphonescore := if(blankOut, 255, le.hphonescore);
	self.verhphone := if(blankOut, '', le.verhphone);
	
	self.wphonescore := if(blankOut, 255, le.wphonescore);
	self.verwphone := if(blankOut, '', le.verwphone);//ri.phone;  // not sure how to handle this yet

	SELF.sources := if(blankOut, '', le.sources);	
	SELF.firstnamesources := if(blankOut, '', le.firstnamesources);
	SELF.lastnamesources := if(blankOut, '', le.lastnamesources);
	SELF.addrsources := if(blankOut, '', le.addrsources);
	SELF.socssources := if(blankOut, '', le.socssources);
	SELF.numsource := if(blankOut, 0, le.numsource);
	
	self.hphonesources := if(blankOut, '', le.hphonesources);
	self.wphonesources := if(blankOut, '', le.wphonesources);
	self.dobsources := if(blankOut, '', le.dobsources);
	self.cmpysources := if(blankOut, '', le.cmpysources);
	
	self.num_nonderogs := if(blankOut, 0, le.num_nonderogs);
	self.num_nonderogs30 := if(blankOut, 0, le.num_nonderogs30);
	self.num_nonderogs90 := if(blankOut, 0, le.num_nonderogs90);
	self.num_nonderogs180 := if(blankOut, 0, le.num_nonderogs180);
	self.num_nonderogs12 := if(blankOut, 0, le.num_nonderogs12);
	self.num_nonderogs24 := if(blankOut, 0, le.num_nonderogs24);
	self.num_nonderogs36 := if(blankOut, 0, le.num_nonderogs36);
	self.num_nonderogs60 := if(blankOut, 0, le.num_nonderogs60);
	self := le;
end;
	
removeVer2 := project(with_socs_codes, removeHeader(left));		
	

layout_output figureChronology(layout_output le) := TRANSFORM
	ver_in_chron := le.verprim_range+le.verprim_name IN [le.chronoprim_range+le.chronoprim_name,
											   le.chronoprim_range2+le.chronoprim_name2,
											   le.chronoprim_range3+le.chronoprim_name3];
	self.chronofirst3 := IF(~ver_in_chron,le.verfirst,le.chronofirst3);
	self.chronolast3 := IF(~ver_in_chron,le.verlast,le.chronolast3);
	self.chronoprim_range3 := IF(~ver_in_chron,le.verprim_range,le.chronoprim_range3);
	self.chronopredir3 := IF(~ver_in_chron,le.verpredir,le.chronopredir3);
	self.chronoprim_name3 := IF(~ver_in_chron,le.verprim_name,le.chronoprim_name3);
	self.chronosuffix3 := IF(~ver_in_chron,le.versuffix,le.chronosuffix3);
	self.chronopostdir3 := IF(~ver_in_chron,le.verpostdir,le.chronopostdir3);
	self.chronounit_desig3 := IF(~ver_in_chron,le.verunit_desig,le.chronounit_desig3);
	self.chronosec_range3 := IF(~ver_in_chron,le.versec_range,le.chronosec_range3);

	self.chronocity3 := IF(~ver_in_chron,le.vercity,le.chronocity3);
	self.chronostate3 := IF(~ver_in_chron,le.verstate,le.chronostate3);
	self.chronozip3 := IF(~ver_in_chron,le.verzip[1..5],le.chronozip3);
	self.chronozip4_3 := IF(~ver_in_chron,le.verzip[6..9],le.chronozip4_3);
	self.chronocounty3 := IF(~ver_in_chron,le.vercounty,le.chronocounty3);
	self.chronogeo_blk3 := IF(~ver_in_chron,le.vergeo_blk,le.chronogeo_blk3);
	
	self.chronodate_last3 := IF(~ver_in_chron,le.verdate_last,le.chronodate_last3);
	self.chronoaddrscore3 := IF(~ver_in_chron,le.addrscore,le.chronoaddrscore3);
	
	input_in_chron := le.prim_range+le.prim_name IN [le.chronoprim_range+le.chronoprim_name,
											   le.chronoprim_range2+le.chronoprim_name2,
											   le.chronoprim_range3+le.chronoprim_name3,
											   le.verprim_range+le.verprim_name];
	input_most_recent := le.prim_range+le.prim_name = le.chronoprim_range+le.chronoprim_name;
	self.inputAddrNotMostRecent := input_in_chron and ~input_most_recent;
	SELF := le;
END;

commonstart := PROJECT(removeVer2, figureChronology(LEFT));


asdf := GROUP(PROJECT(j_header(did<>0),TRANSFORM(header.layout_header, SELF := LEFT.h)));	

w := watchdog.BestAddrFunc(asdf);

layout_output checkBest (layout_output le, w ri) := TRANSFORM
	addrmatchscore := AddrScore(le.prim_range, le.prim_name, le.sec_range, le.in_zipcode,
									 ri.prim_range, ri.prim_name, ri.sec_range, ri.zip);
	addrmatch := ga(addrmatchscore);

	SELF.veraddr_isBest :=
				ga(AddrScore(le.prim_range, le.prim_name, le.sec_range, le.in_zipcode,
						   ri.prim_range, ri.prim_name, ri.sec_range, ri.zip));
	SELF.chronoaddr_isBest := 
				ga(AddrScore(le.chronoprim_range, le.chronoprim_name, le.chronosec_range, le.chronozip,
							ri.prim_range, ri.prim_name, ri.sec_range, ri.zip));
	SELF.chronoaddr_isBest2 :=
				ga(AddrScore(le.chronoprim_range2, le.chronoprim_name2, le.chronosec_range2, le.chronozip2,
							ri.prim_range, ri.prim_name, ri.sec_range, ri.zip));
	SELF.chronoaddr_isBest3 :=
				ga(AddrScore(le.chronoprim_range3, le.chronoprim_name3, le.chronosec_range3, le.chronozip3,
							ri.prim_range, ri.prim_name, ri.sec_range, ri.zip));

	SELF := le;
END;

j := JOIN(commonstart, w, LEFT.did=RIGHT.did, checkBest(LEFT,RIGHT), LEFT OUTER, LOOKUP);

RETURN j;

END;