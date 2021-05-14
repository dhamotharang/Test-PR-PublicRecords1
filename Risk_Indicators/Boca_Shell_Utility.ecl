/*2014-12-03T01:08:27Z (David Schlangen)
changes for bug 156869 and 165691
*/
Import Utilfile, Riskwise, ut, risk_indicators, _Control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Utility(GROUPED dataset(risk_indicators.layout_bocashell_neutral) bs_neutral, unsigned1 glb, boolean isFCRA = false, integer bsversion=40) := FUNCTION

Layout_Utility_Plus := RECORD
	unsigned4 seq;
	risk_indicators.Layouts.Layout_Utility Utility;
	string3 utili_adl_src;	// internal use
	string3 utili_addr1_src;	// internal use
	string3 utili_addr2_src;	// internal use
END;

// New utility types
// =====================
// 1 = Infrastructure (coal, electric, gas, oil, propane gas, water)
// 2 = Convenience (All others fall into the convenience bucket)
// 3 = Miscellaneous (Z)

// mapping handles old records or new records
utility_type_conversion(string db_util_type) := MAP(
trim(db_util_type) IN ['C','E','G','O','P','W','EG','EW','EWZ','1'] => '1',
trim(db_util_type) IN ['Z','3'] => 'Z',
trim(db_util_type) <> '' => '2',
'');

// get utility info per ADL
Layout_Utility_Plus getUtilADL(bs_neutral le, Utilfile.Key_DID ri) := transform
	util_type_mapped := utility_type_conversion(ri.util_type);
	self.utili_adl_src := util_type_mapped;
	
	self.Utility.utili_adl_type := if(util_type_mapped<>'', util_type_mapped+',', '');
	self.Utility.utili_adl_dt_first_seen := if(util_type_mapped<>'', ri.date_first_seen+',', '');					
	self.Utility.utili_adl_count := (integer)((unsigned)ri.did<>0);
	
	firstmatch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.shell_input.fname, ri.fname));
	lastmatch := risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.shell_input.lname, ri.lname));
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.shell_input.in_zipcode, ri.zip);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.shell_input.in_city, le.shell_input.in_state, ri.p_city_name, ri.st, le.iid.cityzipflag);
	addrmatch := risk_indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						zip_score, cityst_score) );
	
	phonematch := risk_indicators.iid_constants.gn(risk_indicators.PhoneScore(le.shell_input.phone10, ri.phone));
	self.Utility.utili_adl_nap := risk_indicators.iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	self := le;
	self := [];
end;

wUtilADL_roxie := join(bs_neutral, Utilfile.Key_DID, 
                      (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                      left.did<>0 and
                      keyed(left.did=right.s_did) and 
                      (unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
                      getUtilADL(left,right), left outer,
                      ATMOST(keyed (left.did=right.s_did), riskwise.max_atmost), KEEP(200));
                              
// wUtilADL_thor := join(DISTRIBUTE(bs_neutral, HASH64(did)),
                      // DISTRIBUTE(PULL(Utilfile.Key_DID), HASH64(s_did)),
                      // left.did<>0 and
                      // (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                      // left.did=right.s_did and 
                      // (unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
                      // getUtilADL(left,right), left outer,
                      // ATMOST(left.did=right.s_did, riskwise.max_atmost), KEEP(200), LOCAL);
                      
wUtilADL_thor := join(DISTRIBUTE(bs_neutral(did <> 0), HASH64(did)),
                      DISTRIBUTE(PULL(Utilfile.Key_DID), HASH64(s_did)),
                      // left.did<>0 and
                      (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                      left.did=right.s_did and 
                      (unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
                      getUtilADL(left,right), left outer,
                      ATMOST(left.did=right.s_did, riskwise.max_atmost), KEEP(200), LOCAL)
                      //is this correct?
                      +
                      PROJECT(bs_neutral(did = 0), TRANSFORM(Layout_Utility_Plus, SELF := LEFT, SELF := []));
                      
#IF(onThor)
	wUtilADL_correct := wUtilADL_thor;
#ELSE
	wUtilADL_correct := wUtilADL_roxie;
#END
										
// get utility info per Addr 1
Layout_Utility_Plus getUtilAddr(bs_neutral le, utilfile.Key_Address ri) := transform

	// for shell 5.0, limit some of these fields to just the time period of when the subject lived there, bug 165691
	valid_utility := bsversion < 50 or (unsigned)ri.date_first_seen<>0 and
							(unsigned)(ri.date_first_seen[1..6]) between le.address_verification.input_address_information.date_first_seen and 
																													le.address_verification.input_address_information.date_last_seen;

	util_type_mapped := utility_type_conversion(ri.util_type);
	self.utili_addr1_src := util_type_mapped;
	self.Utility.utili_addr1_type := if(util_type_mapped<>'' and valid_utility, util_type_mapped+',', '');
	self.Utility.utili_addr1_dt_first_seen := if(util_type_mapped<>'' and valid_utility, trim(ri.date_first_seen)+',', '');
	self.Utility.utili_addr1_nap := risk_indicators.iid_constants.comp_nap(le.Name_Verification.fname_utility_sourced, le.iid.utiliaddr_lastcount>0, le.iid.utiliaddr_addrcount>0, le.iid.utiliaddr_phonecount>0);
	
	self := le;
	self := [];
end;

wUtilAddr1_roxie := JOIN(bs_neutral, UtilFile.Key_Address,
                        (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                        left.shell_input.z5!='' and left.shell_input.prim_name != '' and
                        keyed (left.shell_input.prim_name=right.prim_name) and keyed(left.shell_input.st=right.st) and 
                        keyed(left.shell_input.z5=right.zip) and keyed(left.shell_input.prim_range=right.prim_range) and keyed(left.shell_input.sec_range=right.sec_range) and		
                        // check date
                        ((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
                        // addr type = 'S' means that this is the service address
                        RIGHT.addr_type='S',
                         getUtilAddr(left,right), left outer, 
                         ATMOST(
                          keyed (left.shell_input.prim_name=right.prim_name) and keyed(left.shell_input.st=right.st) and 
                          keyed(left.shell_input.z5=right.zip) and keyed(left.shell_input.prim_range=right.prim_range) and 
                          keyed(left.shell_input.sec_range=right.sec_range), 100));
                          
wUtilAddr1_thor := JOIN(DISTRIBUTE(bs_neutral(shell_input.z5 != '' AND shell_input.prim_name != ''), HASH64(shell_input.prim_name, shell_input.st, shell_input.z5, shell_input.prim_range, shell_input.sec_range)), 
                        DISTRIBUTE(PULL(UtilFile.Key_Address), HASH64(prim_name, st, zip, prim_range, sec_range)),
                        // left.shell_input.z5!='' and left.shell_input.prim_name != '' and
                        (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                        left.shell_input.prim_name=right.prim_name and 
                        left.shell_input.st=right.st and 
                        left.shell_input.z5=right.zip and 
                        left.shell_input.prim_range=right.prim_range and 
                        left.shell_input.sec_range=right.sec_range and		
                        // check date
                        ((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
                        // addr type = 'S' means that this is the service address
                        RIGHT.addr_type='S',
                         getUtilAddr(left,right), left outer, 
                         ATMOST(
                          left.shell_input.prim_name=right.prim_name and left.shell_input.st=right.st and 
                          left.shell_input.z5=right.zip and left.shell_input.prim_range=right.prim_range and 
                          left.shell_input.sec_range=right.sec_range, 100), LOCAL)
                        //is this correct?
                        +
                        PROJECT(bs_neutral(shell_input.z5 = '' OR shell_input.prim_name = ''), TRANSFORM(Layout_Utility_Plus, SELF := LEFT, SELF := []));
                          
#IF(onThor)
	wUtilAddr1_correct := wUtilAddr1_thor;
#ELSE
	wUtilAddr1_correct := wUtilAddr1_roxie;
#END
																	
									
// get utility info per Addr 2
Layout_Utility_Plus getUtilAddr2(bs_neutral le, utilfile.Key_Address ri) := transform

	// limit some of these fields to just the time period of when the subject lived there, bug 165691
	valid_utility := bsversion < 50 or (unsigned)ri.date_first_seen<>0 and
							(unsigned)(ri.date_first_seen[1..6]) between le.address_verification.address_history_1.date_first_seen and 
																													le.address_verification.address_history_1.date_last_seen;

	util_type_mapped := utility_type_conversion(ri.util_type);
	self.utili_addr2_src := util_type_mapped;
	self.Utility.utili_addr2_type := if(util_type_mapped<>'' and valid_utility, trim(util_type_mapped)+',', '');
	self.Utility.utili_addr2_dt_first_seen := if(util_type_mapped<>'' and valid_utility, trim(ri.date_first_seen)+',', '');
	
	firstmatch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.shell_input.fname, ri.fname));
	lastmatch := risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.shell_input.lname, ri.lname));
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.address_verification.address_history_1.zip5, ri.zip);
	cityst_score := Risk_Indicators.AddrScore.citystate_score(le.address_verification.address_history_1.city_name, le.address_verification.address_history_1.st, 
																															ri.p_city_name, ri.st, '1');  // set cityzipflag = 1 to ignore the vanity city name check
	addrmatch := risk_indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.address_verification.address_history_1.prim_range, le.address_verification.address_history_1.prim_name, le.address_verification.address_history_1.sec_range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						zip_score, cityst_score) );
	
	phonematch := risk_indicators.iid_constants.gn(risk_indicators.PhoneScore(le.shell_input.phone10, ri.phone));
	self.Utility.utili_addr2_nap := risk_indicators.iid_constants.comp_nap(firstmatch, lastmatch, addrmatch, phonematch);
	self := le;
	self := [];
end;

wUtilAddr2_roxie := JOIN(bs_neutral, UtilFile.Key_Address,
                        (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                        left.address_verification.address_history_1.zip5!='' and left.address_verification.address_history_1.prim_name != '' and
                        keyed (left.address_verification.address_history_1.prim_name=right.prim_name) and keyed(left.address_verification.address_history_1.st=right.st) and 
                        keyed(left.address_verification.address_history_1.zip5=right.zip) and keyed(left.address_verification.address_history_1.prim_range=right.prim_range) and 
                        keyed(left.address_verification.address_history_1.sec_range=right.sec_range) and		
                        // check date
                        ((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
                        // addr type = 'S' means that this is the service address
                        RIGHT.addr_type='S',
                         getUtilAddr2(left,right), left outer, 
                         ATMOST(
                          keyed (left.address_verification.address_history_1.prim_name=right.prim_name) and keyed(left.address_verification.address_history_1.st=right.st) and 
                          keyed(left.address_verification.address_history_1.zip5=right.zip) and keyed(left.address_verification.address_history_1.prim_range=right.prim_range) and 
                          keyed(left.address_verification.address_history_1.sec_range=right.sec_range), 100));
                          
wUtilAddr2_thor := JOIN(DISTRIBUTE(bs_neutral(address_verification.address_history_1.zip5 <> '' AND address_verification.address_history_1.prim_name <> ''),
                          HASH64(address_verification.address_history_1.prim_name, 
                                 address_verification.address_history_1.st,
                                 address_verification.address_history_1.zip5,
                                 address_verification.address_history_1.prim_range,
                                 address_verification.address_history_1.sec_range)),
                        DISTRIBUTE(PULL(UtilFile.Key_Address), 
                          HASH64(prim_name, st, zip, prim_range, sec_range)),
                        // LEFT.address_verification.address_history_1.zip5 <> '' AND LEFT.address_verification.address_history_1.prim_name <> '' AND
                        (isFCRA or ut.PermissionTools.glb.ok( glb)) and
                        left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.st=right.st and 
                        left.address_verification.address_history_1.zip5=right.zip and left.address_verification.address_history_1.prim_range=right.prim_range and 
                        left.address_verification.address_history_1.sec_range=right.sec_range and		
                        // check date
                        ((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate)) AND
                        // addr type = 'S' means that this is the service address
                        RIGHT.addr_type='S',
                         getUtilAddr2(left,right), left outer, 
                         ATMOST(
                          left.address_verification.address_history_1.prim_name=right.prim_name and left.address_verification.address_history_1.st=right.st and 
                          left.address_verification.address_history_1.zip5=right.zip and left.address_verification.address_history_1.prim_range=right.prim_range and 
                          left.address_verification.address_history_1.sec_range=right.sec_range, 100), LOCAL)
                        //is this correct?
                        +
                        PROJECT(bs_neutral(address_verification.address_history_1.zip5 = '' OR address_verification.address_history_1.prim_name = ''),
                                TRANSFORM(Layout_Utility_Plus, SELF := LEFT, SELF := []));
                          
#IF(onThor)
	wUtilAddr2_correct := wUtilAddr2_thor;
#ELSE
	wUtilAddr2_correct := wUtilAddr2_roxie;
#END
																	
																	
Layout_Utility_Plus rollUtil(Layout_Utility_Plus le, Layout_Utility_Plus ri) := transform
	adl_type_seen := Stringlib.StringFind(trim(le.Utility.utili_adl_type),trim(ri.utili_adl_src)+',',1)>0 OR (le.Utility.utili_adl_type='' and ri.utili_adl_src='');
	self.Utility.utili_adl_type := IF(adl_type_seen, le.Utility.utili_adl_type, TRIM(le.Utility.utili_adl_type)+trim(ri.utili_adl_src)+','); 
	self.Utility.utili_adl_dt_first_seen := if(adl_type_seen, le.Utility.utili_adl_dt_first_seen, TRIM(le.Utility.utili_adl_dt_first_seen)+trim(ri.Utility.utili_adl_dt_first_seen));
	self.Utility.utili_adl_count := le.Utility.utili_adl_count + ri.Utility.utili_adl_count;
	self.Utility.utili_adl_earliest_dt_first_seen := (string8)ut.Min2((unsigned)le.Utility.utili_adl_dt_first_seen, (unsigned)ri.Utility.utili_adl_dt_first_seen);
	self.Utility.utili_adl_nap := MAX(le.Utility.utili_adl_nap,ri.Utility.utili_adl_nap);
	self.utili_adl_src := ri.utili_adl_src;

	addr1_type_seen := Stringlib.StringFind(trim(le.Utility.utili_addr1_type),trim(ri.utili_addr1_src)+',',1)>0 OR (le.Utility.utili_addr1_type='' and ri.utili_addr1_src='');
	self.Utility.utili_addr1_type := IF(addr1_type_seen, le.Utility.utili_addr1_type, TRIM(le.Utility.utili_addr1_type)+trim(ri.utili_addr1_src)+','); 
	self.Utility.utili_addr1_dt_first_seen := if(addr1_type_seen, le.Utility.utili_addr1_dt_first_seen, TRIM(le.Utility.utili_addr1_dt_first_seen)+trim(ri.Utility.utili_addr1_dt_first_seen));
	self.Utility.utili_addr1_nap := MAX(le.Utility.utili_addr1_nap,ri.Utility.utili_addr1_nap);
	self.utili_addr1_src := ri.utili_addr1_src;

	addr2_type_seen := Stringlib.StringFind(trim(le.Utility.utili_addr2_type),trim(ri.utili_addr2_src)+',',1)>0 OR (le.Utility.utili_addr2_type='' and ri.utili_addr2_src='');
	self.Utility.utili_addr2_type := IF(addr2_type_seen, le.Utility.utili_addr2_type, TRIM(le.Utility.utili_addr2_type)+trim(ri.utili_addr2_src)+','); 
	self.Utility.utili_addr2_dt_first_seen := if(addr2_type_seen, le.Utility.utili_addr2_dt_first_seen, TRIM(le.Utility.utili_addr2_dt_first_seen)+trim(ri.Utility.utili_addr2_dt_first_seen));
	self.Utility.utili_addr2_nap := MAX(le.Utility.utili_addr2_nap,ri.Utility.utili_addr2_nap);
	self.utili_addr2_src := ri.utili_addr2_src;

	self := le;
end;


sUtilADL_roxie := sort(wUtilADL_correct, seq, utility.utili_adl_dt_first_seen, utility.utili_adl_type, utility.utili_adl_nap);
// sUtilADL_thor := sort(wUtilADL_correct, seq, utility.utili_adl_dt_first_seen, utility.utili_adl_type, utility.utili_adl_nap);
sUtilADL_thor := sort(DISTRIBUTE(wUtilADL_correct, HASH64(seq)), seq, utility.utili_adl_dt_first_seen, utility.utili_adl_type, utility.utili_adl_nap, LOCAL);

sUtilAddr1_roxie := sort(wUtilAddr1_correct, Utility.utili_addr1_dt_first_seen, utility.utili_addr1_type, utility.utili_addr1_nap);
// sUtilAddr1_thor := sort(wUtilAddr1_correct, Utility.utili_addr1_dt_first_seen, utility.utili_addr1_type, utility.utili_addr1_nap);
sUtilAddr1_thor := sort(DISTRIBUTE(wUtilAddr1_correct, HASH64(seq)), seq, Utility.utili_addr1_dt_first_seen, utility.utili_addr1_type, utility.utili_addr1_nap, LOCAL);

sUtilAddr2_roxie := sort(wUtilAddr2_correct, Utility.utili_addr2_dt_first_seen, utility.utili_addr2_type, utility.utili_addr2_nap);
// sUtilAddr2_thor := sort(wUtilAddr2_correct, Utility.utili_addr2_dt_first_seen, utility.utili_addr2_type, utility.utili_addr2_nap);
sUtilAddr2_thor := sort(DISTRIBUTE(wUtilAddr2_correct, HASH64(seq)), seq, Utility.utili_addr2_dt_first_seen, utility.utili_addr2_type, utility.utili_addr2_nap, LOCAL);

#IF(onThor)
	sUtilADL    := sUtilADL_thor;
  sUtilAddr1  := sUtilAddr1_thor;
  sUtilAddr2  := sUtilAddr2_thor;
#ELSE
	sUtilADL    := sUtilADL_roxie;
  sUtilAddr1  := sUtilAddr1_roxie;
  sUtilAddr2  := sUtilAddr2_roxie;
#END

rollAdlUtil_roxie := rollup(GROUP(sUtilADL, seq), left.seq=right.seq, rollUtil(left,right));
rollAdlUtil_thor := rollup(GROUP(DISTRIBUTE(sUtilADL, HASH64(seq)), seq, LOCAL), left.seq=right.seq, rollUtil(left,right));
	
rollAddr1Util_roxie := rollup(GROUP(sUtilAddr1, seq), left.seq=right.seq, rollUtil(left,right));
// rollAddr1Util_thor := rollup(GROUP(sUtilAddr1, seq), left.seq=right.seq, rollUtil(left,right));
rollAddr1Util_thor := rollup(GROUP(DISTRIBUTE(sUtilAddr1, HASH64(seq)), seq, LOCAL), left.seq=right.seq, rollUtil(left,right));
	
rollAddr2Util_roxie := rollup(GROUP(sUtilAddr2, seq), left.seq=right.seq, rollUtil(left,right));
// rollAddr2Util_thor := rollup(GROUP(sUtilAddr2, seq), left.seq=right.seq, rollUtil(left,right));
rollAddr2Util_thor := rollup(GROUP(DISTRIBUTE(sUtilAddr2, HASH64(seq)), seq, LOCAL), left.seq=right.seq, rollUtil(left,right));	

#IF(onThor)
  rollAdlUtil   := rollAdlUtil_thor;
  rollAddr1Util := rollAddr1Util_thor;
  rollAddr2Util := rollAddr2Util_thor;
#ELSE
	rollAdlUtil   := rollAdlUtil_roxie;
  rollAddr1Util := rollAddr1Util_roxie;
  rollAddr2Util := rollAddr2Util_roxie;
#END

// join all 3 sets of results back to bs_neutral here
wUtilityADL_roxie := join(bs_neutral, rollAdlUtil, left.seq=right.seq, 
transform(risk_indicators.layout_bocashell_neutral,
	self.Utility.utili_adl_type := right.Utility.utili_adl_type; 
	self.Utility.utili_adl_dt_first_seen := right.Utility.utili_adl_dt_first_seen; 
	self.Utility.utili_adl_count := right.Utility.utili_adl_count; 
	self.Utility.utili_adl_earliest_dt_first_seen := right.Utility.utili_adl_earliest_dt_first_seen; 
	self.Utility.utili_adl_nap := right.Utility.utili_adl_nap; 
	// self.utili_adl_src := right.utili_adl_src; 
	self := left;
	), left outer, lookup);

wUtilityAddr1_roxie := join(wUtilityADL_roxie, rollAddr1Util, left.seq=right.seq, 
transform(risk_indicators.layout_bocashell_neutral,
	self.Utility.utili_addr1_type := right.Utility.utili_addr1_type; 
	self.Utility.utili_addr1_dt_first_seen := right.Utility.utili_addr1_dt_first_seen;
	self.Utility.utili_addr1_nap := right.Utility.utili_addr1_nap;
	// self.utili_addr1_src := right.utili_addr1_src;
	self := left;
	), left outer, lookup);

wUtilityAddr2_roxie := join(wUtilityAddr1_roxie, rollAddr2Util, left.seq=right.seq, 
transform(risk_indicators.layout_bocashell_neutral,
	self.Utility.utili_addr2_type := right.Utility.utili_addr2_type; 
	self.Utility.utili_addr2_dt_first_seen := right.Utility.utili_addr2_dt_first_seen;
	self.Utility.utili_addr2_nap := right.Utility.utili_addr2_nap;
	// self.utili_addr2_src := right.utili_addr2_src;
	self := left;
	), left outer, lookup);
  
wUtilityADL_thor := join(DISTRIBUTE(bs_neutral, HASH64(seq)), DISTRIBUTE(rollAdlUtil, HASH64(seq)), 
                          left.seq=right.seq, 
                          transform(risk_indicators.layout_bocashell_neutral,
                            self.Utility.utili_adl_type := right.Utility.utili_adl_type; 
                            self.Utility.utili_adl_dt_first_seen := right.Utility.utili_adl_dt_first_seen; 
                            self.Utility.utili_adl_count := right.Utility.utili_adl_count; 
                            self.Utility.utili_adl_earliest_dt_first_seen := right.Utility.utili_adl_earliest_dt_first_seen; 
                            self.Utility.utili_adl_nap := right.Utility.utili_adl_nap; 
                            // self.utili_adl_src := right.utili_adl_src; 
                            self := left;
                            ), left outer, LOCAL);

wUtilityAddr1_thor := join(DISTRIBUTE(wUtilityADL_thor, HASH64(seq)), DISTRIBUTE(rollAddr1Util, HASH64(seq)), 
                            left.seq=right.seq, 
                            transform(risk_indicators.layout_bocashell_neutral,
                              self.Utility.utili_addr1_type := right.Utility.utili_addr1_type; 
                              self.Utility.utili_addr1_dt_first_seen := right.Utility.utili_addr1_dt_first_seen;
                              self.Utility.utili_addr1_nap := right.Utility.utili_addr1_nap;
                              // self.utili_addr1_src := right.utili_addr1_src;
                              self := left;
                              ), left outer, LOCAL);

wUtilityAddr2_thor := join(DISTRIBUTE(wUtilityAddr1_thor, HASH64(seq)), DISTRIBUTE(rollAddr2Util, HASH64(seq)), 
                            left.seq=right.seq, 
                            transform(risk_indicators.layout_bocashell_neutral,
                              self.Utility.utili_addr2_type := right.Utility.utili_addr2_type; 
                              self.Utility.utili_addr2_dt_first_seen := right.Utility.utili_addr2_dt_first_seen;
                              self.Utility.utili_addr2_nap := right.Utility.utili_addr2_nap;
                              // self.utili_addr2_src := right.utili_addr2_src;
                              self := left;
                              ), left outer, LOCAL);
                              
#IF(onThor)
  wUtilityAddr2 := wUtilityAddr2_thor;
#ELSE
  wUtilityAddr2 := wUtilityAddr2_roxie;
#END

wUtility := group(sort(wUtilityAddr2,seq),seq);

// output(wUtilADL, named('wUtilADL'));
// output(wutil, named('wutil'));
// output(sutil, named('sutil'));
// output(rollUtilout, named('rollUtilout'));

// OUTPUT(wUtilADL_correct, NAMED('wUtilADL_correct'));
// OUTPUT(wUtilAddr1_correct, NAMED('wUtilAddr1_correct'));
// OUTPUT(wUtilAddr2_correct, NAMED('wUtilAddr2_correct'));

// OUTPUT(sUtilADL, NAMED('sUtilADL'));
// OUTPUT(sUtilAddr1, NAMED('sUtilAddr1'));
// OUTPUT(sUtilAddr2, NAMED('sUtilAddr2'));
// OUTPUT(rollAdlUtil, NAMED('rollAdlUtil'));
// OUTPUT(rollAddr1Util, NAMED('rollAddr1Util'));
// OUTPUT(rollAddr2Util, NAMED('rollAddr2Util'));

/*
	sUtilADL    := sUtilADL_thor;
  sUtilAddr1  := sUtilAddr1_thor;
  sUtilAddr2  := sUtilAddr2_thor;

	rollAdlUtil   := rollAdlUtil_roxie;
  rollAddr1Util := rollAddr1Util_roxie;
  rollAddr2Util := rollAddr2Util_roxie;
*/

return wUtility;

END;