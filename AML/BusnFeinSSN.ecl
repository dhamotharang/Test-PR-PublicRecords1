IMPORT FAA, RiskWise, doxie, Risk_Indicators, business_risk;

EXPORT BusnFeinSSN(DATASET(Layouts.BusnExecsLayoutV2) BusnIds,
																string50 DataRestriction, 
																unsigned1 GLBA ) := FUNCTION
//Version 2
isFCRA := false;
min_score := 80;
min_addrscore := 70; 
min_numscore := 90;
gaScore(UNSIGNED1 i) := i BETWEEN min_addrscore AND 100;
gScore(UNSIGNED1 i) := i BETWEEN min_score AND 100;

AR2BDIDs := project(BusnIds, transform(doxie.layout_references, self.did:=left.DID));


checkASSOCssn :=   Risk_Indicators.Collection_Shell_MOD.getBestCleaned(AR2BDIDs, DataRestriction, GLBA, false);


AddBDIDSSN := join(BusnIds, checkASSOCssn,
                   left.did=right.did,
									 transform({recordof(checkASSOCssn), unsigned6 bdid}, 
															self.bdid:=left.bdid, 
															self.seq := left.seq,
															self := right),
									 left outer);
									 
AR2BILayout := record
  unsigned4		seq;
	unsigned6 	bdid;
	unsigned6   AR2BiDID;
	boolean     SSNMatch;
  string9   	fein;
	STRING9     ssn;
END;


AR2BILayout check_Fein_AR2BI(BusnIds l, AddBDIDSSN r) := transform
	self.AR2BiDID := (unsigned6)r.did;
	self.seq := l.seq;
	self.bdid := l.bdid;
	self.SSNMatch := if(r.ssn = '', false, if(l.bestfein = r.ssn or l.fein = r.ssn, true, false));
	self.fein := if(l.bestfein = '', l.fein, l.bestfein);
	self.ssn := r.ssn;
end;

FeinMatch := join(BusnIds, AddBDIDSSN,  
									left.bdid = right.bdid and 
									left.seq = right.seq and
									left.did = right.did,
									check_Fein_AR2BI(left,right), left outer);
									
									
AddFeinMatch := join(BusnIds, FeinMatch,
                     left.seq=right.seq and
												left.bdid=right.bdid and
												left.did = right.ar2bidid,
												transform(Layouts.BusnExecsLayoutV2,
													      self.IndSSNMatch := right.SSNMatch,
														  	self  := left),
													left outer);
													
// ----------- BEGIN BNAS ------Busn----------/

for_BNAS := record
	Layouts.BusnExecsLayoutV2;
	boolean	addrmatch;
	boolean	namematch;
	boolean	ssnmatch;
end;

DSbusnids := dedup(sort(BusnIds, seq, bdid), seq, bdid);

for_BNAS check_TIN_as_SSN(DSbusnids L, business_risk.Key_SSN_Address R) := transform
	self.addrmatch := gaScore(Risk_Indicators.AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range, 
																						r.prim_range, r.prim_name, r.sec_range));
	self.namematch := gScore(Business_Risk.CnameScore(L.company_name,trim(R.fname) + ' ' + trim(R.mname) + ' ' +trim(r.lname)));
	self.ssnmatch := if(l.fein='', 0, if(L.fein = R.ssn, 1, 0));
	self := l;
	self := [];
end;



w_ssncheck := join(DSbusnids,  business_risk.Key_SSN_Address,
					left.prim_name != '' and
					keyed(left.fein = right.ssn) and
					keyed(left.prim_name = right.prim_name),
			    check_TIN_as_SSN(LEFT,RIGHT),
			    left outer, atmost(keyed(left.fein = right.ssn) and
					keyed(left.prim_name = right.prim_name), riskwise.max_atmost), keep(100));
			    

for_bnas roll_SSN(for_bnas L, for_bnas R) := transform
	self.addrmatch := L.addrmatch or R.addrmatch;
	self.ssnmatch  := L.ssnmatch  or R.ssnmatch;
	self.namematch := L.namematch or R.nameMatch;
	self := L;
end;

rolled_bnas := rollup(w_ssncheck, left.seq=right.seq and 
																	left.bdid=right.bdid and
																	left.origbdid = right.origbdid, 
																	roll_SSN(LEFT,RIGHT));
																	


AddBusnBnas  := join(AddFeinMatch, rolled_bnas,
                     left.seq=right.seq and
										 left.bdid=right.bdid and
										 left.origbdid = right.origbdid,
										 transform(Layouts.BusnExecsLayoutV2, 
															self.IndSSNMatch := if(left.IndSSNMatch or right.ssnmatch, true, false);
															self := left),
											left outer);
											
											



// OUTPUT(BusnIds, NAMED('BusnIds'));
// OUTPUT(AR2BDIDs, NAMED('AR2BDIDs'));
// OUTPUT(checkASSOCssn, NAMED('checkASSOCssn'));
// OUTPUT(AddBDIDSSN, NAMED('AddBDIDSSN'));
// OUTPUT(AddFeinMatch, NAMED('AddFeinMatch'));
// OUTPUT(FeinMatch, NAMED('FeinMatch'));
// OUTPUT(w_ssncheck, NAMED('w_ssncheck'));
// OUTPUT(rolled_bnas, NAMED('rolled_bnas'));
// OUTPUT(AddBusnBnas, NAMED('AddBusnBnas'));
											
RETURN 		AddBusnBnas;
									
END;	