import ut, header, mdr, census_data, Infutor, doxie;

export us_search :=
FUNCTION

doxie.mac_header_field_declare();
mod_access := doxie.compliance.GetGlobalDataAccessModule ();

d := IF(reduced_data_value,GROUP(header_references(false), did));


usHeaderPretty_MACRO(key_hp,hp_out) := MACRO

#uniquename(take)
doxie.layout_header_records %take%(d le, key_hp ri) := transform
  pen :=  Doxie.FN_Tra_Penalty_Name(ri.fname,ri.mname,ri.lname)+
					doxie.FN_Tra_Penalty_Addr(ri.predir,ri.prim_range,ri.prim_name,ri.suffix,ri.postdir,ri.sec_range,
																		ri.city_name,ri.st,'',false)+
					doxie.FN_Tra_Penalty_DOB((string)ri.dob);
	
	// bug 51421 -- account for Dial_Record_Match override of penalty threshold filter
	// same test as applied in doxie_header_records_byDID
	self.penalt := if (pen < score_threshold_value or Dial_RecordMatch_value > 3, pen, skip);

	self.src := ri.src;

	// for efficiency, we know only non_glb
  pre_glb := mod_access.isHeaderPreGLB ((unsigned3)ri.dt_nonglb_last_seen, (unsigned3)ri.dt_first_seen, ri.src);
	self.did := IF(pre_glb,ri.did,SKIP);
	
	SELF.dt_first_seen := ri.dt_first_seen;
	SELF.dt_last_seen := ri.dt_last_seen;
	SELF.dt_vendor_first_reported := ri.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported := ri.dt_vendor_last_reported;
	SELF.dt_nonglb_last_seen := ri.dt_nonglb_last_seen;

	SELF.title := ri.title;
	SELF.fname := ri.fname;
	SELF.mname := ri.mname;
	SELF.lname := ri.lname;
	SELF.name_suffix := ri.name_suffix;
	
	SELF.city_name := ri.city_name;
	SELF.st := ri.st;
	SELF.zip := ri.zip; /* to add zip5 in results display*/
	SELF.zip4 := ri.zip4;
	SELF.county := ri.county;
	SELF.geo_blk := ri.geo_blk;
	
	SELF.dob := ri.dob;
	SELF.ssn := ri.ssn;
	
	self := [];
  end;
  
// get header records
	hp_out := join(d, key_hp, left.did=right.s_did, %take%(left,right), LIMIT(ut.limits .DID_PER_PERSON, SKIP));							 							 

ENDMACRO;

usHeaderPretty_MACRO(Infutor.Key_Header_Infutor_Knowx,infr_out1)
usHeaderPretty_MACRO(doxie.key_header,hdr_out1)
us_headerPretty := if(mod_access.isConsumer(),infr_out1,hdr_out1);

header.MAC_GlbClean_Header(us_headerPretty,headerCleaned, , , mod_access);

// check we don't have too many records
presRecs := limit(headerCleaned,10000,FAIL(11, doxie.ErrorCodes(11)));

high_valid_ssn := 100; // default high value; lowest is best
high_tnt := 100; // default high value; lowest is best
high_penalt := 100; // default high value; lowest is best
srchedAddrThold := 4;
unsigned al := 15 : stored('AddressLimit');
unsigned addrLim := IF(al > 99, 99, al);

Layout_HeaderFileSearch trans(presRecs le) :=
TRANSFORM
	SELF.did := IF(le.did=0,'',INTFORMAT(le.did,12,1));
	SELF.rid := MAP(le.src='PH'	=>	SELF.did+'PH'+(STRING)le.phone, 
					le.src in MDR.sourceTools.set_Daily_Utility_sources	=>	SELF.did+'UT'+(STRING)le.rid, 
					le.src='QH'	=>	SELF.did+'QH'+(STRING)le.rid,
									(STRING)le.rid);
// note that although daily utilities are split into good and bad, method for 'rid' above is the same for both.
	SELF.src := MAP (le.src = MDR.sourceTools.src_Daily_Utilities  =>'UT',
	                 le.src = MDR.sourceTools.src_Daily_ZUtilities =>'ZT',
	                 le.src);
	SELF.first_seen := le.dt_first_seen;
	// for efficiency, we know only non_glb
	SELF.last_seen := IF(mod_access.isConsumer(), le.dt_last_seen, le.dt_nonglb_last_seen);
	SELF.name_suffix := IF( le.name_suffix[1]='U','',le.name_suffix );
	SELF.age := ut.age(le.dob);
	SELF := le;
	SELF := [];
END;

ta3 := PROJECT(presRecs,trans(LEFT));
//output(ta3, named('ta'));
names := doxie.rollup_components(ta3).name;
addresses := doxie.rollup_components(ta3).addresses(pname_value, city_value, state_value, phone_value, zip_value);
dobs := doxie.rollup_components(ta3).dob;


addresses appendcensus(addresses le, census_data.Key_Smart_Jury ri) :=
TRANSFORM
	SELF.a.census_age := ri.age;
	SELF.a.census_income := ri.income;
	SELF.a.census_home_value := ri.home_value;
	SELF.a.census_education := ri.education;
	SELF := le;
END;

j := JOIN(addresses, census_data.Key_Smart_Jury,
										 left.a.county = right.county and
										 left.a.geo_blk[1..6] = right.tract and 
										 left.a.geo_blk[7] =right.blkgrp, appendCensus(LEFT,RIGHT), keep(1), LEFT OUTER);

// keep the highest rid to provide deterministic result order
maxrids := DEDUP(SORT(ta3,-(unsigned6)rid), true, keep(1));

// ******************** Pull components into the parent and keep first N ********************* 
doxie.Layout_Rollup.KeyRec seedDids(maxrids l) := TRANSFORM
	SELF.did := l.did;
	SELF.penalt := high_penalt;
	SELF.num_compares := 0;
	SELF.bestSrchedAddrTntScore := high_tnt;
	SELF.bestSrchedAddrDate := 0;
	SELF.bestSrchedValidSSNScore := high_valid_ssn;
	SELF.bestTntScore := high_tnt;
	SELF.nameRecs := [];
	SELF.addrRecs := [];
	SELF.ssnRecs := [];
	SELF.dobRecs := [];
	SELF.dodRecs := [];
	SELF.rids := [];
	SELF.maxRid := (unsigned6) l.rid;
	SELF.maxDate := 0;
	SELF.DLRecs := [];
	SELF := l;
	SELF.WorkPhones := [];
	SELF.RelativePhones := [];
	SELF.RelativeNames := [];
	SELF.PAW := [];
	SELF.PAW_V2 := [];
END;

KeyRecs := PROJECT(maxrids, seedDids(LEFT));

doxie.Layout_Rollup.KeyRec denormNames(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.NameRecDid R) := TRANSFORM
	SELF.nameRecs := L.nameRecs + R.n;
	SELF.penalt := MIN(L.penalt, R.penalt);
	SELF.num_compares := 0;	
	SELF := L;
END;

doxie.Layout_Rollup.KeyRec denormAddrs(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.AddrRecDid R, INTEGER i) := TRANSFORM
  SELF.addrs_suppressed := L.addrs_suppressed OR i > addrLim;
  SELF.addrRecs := L.addrRecs + IF(~SELF.addrs_suppressed,DATASET(R.a));
	SELF.penalt := MIN(L.penalt, R.penalt);
	SELF.num_compares := 0;	
	SELF.bestSrchedAddrTntScore := IF(L.bestSrchedAddrTntScore < R.bestSrchedAddrTntScore, L.bestSrchedAddrTntScore, R.bestSrchedAddrTntScore);
	SELF.bestSrchedAddrDate := MAX(L.bestSrchedAddrDate, R.bestSrchedAddrDate);
	SELF.bestTntScore := IF(L.bestTntScore < R.bestTntScore, L.bestTntScore, R.bestTntScore);
	SELF := L;
END;

doxie.Layout_Rollup.KeyRec denormDobs(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.DobRecDid R) := TRANSFORM
	SELF.dobRecs := L.dobRecs + R.d;
	SELF.penalt := MIN(L.penalt, R.penalt);
	SELF.num_compares := 0;	
	SELF := L;
END;

// generally, we have limited the number of records per did in the rollup_components module
outRecs1 := DENORMALIZE(KeyRecs, names, LEFT.did = RIGHT.did, denormNames(LEFT,RIGHT));
// here, the counter keeps the datasets under the limit (see transforms above)
outRecs2 := DENORMALIZE(outRecs1, addresses, LEFT.did = RIGHT.did, denormAddrs(LEFT,RIGHT,COUNTER));
outRecs3 := DENORMALIZE(outRecs2, dobs, LEFT.did = RIGHT.did, denormDobs(LEFT,RIGHT));

doxie.Layout_Rollup.KeyRec reSort(doxie.Layout_Rollup.KeyRec L) := TRANSFORM
	// get the latest of all dates
	maxFirst := MAX(L.addrRecs,first_seen);
	maxLast := MAX(L.addrRecs,last_seen);
	SELF.maxDate := MAX(maxFirst,maxLast);
	SELF := L;
END;

outRecs6 := PROJECT(outRecs3, reSort(LEFT));
// sort entries with DID before those without (after searched SSN and searched address TNT)
ta1_srtd := sort(outRecs6, includedByHHID, penalt,bestSrchedValidSSNScore, bestSrchedAddrTntScore, -((unsigned6)did <> 0),
            -bestSrchedAddrDate, bestTntScore,-maxDate,-head_cnt,maxRid);

RETURN ta1_srtd;
END;
