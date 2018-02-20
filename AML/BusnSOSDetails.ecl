import Risk_indicators, corp2, BusReg, business_header, RiskWise, Address_attributes, ut, MDR, Business_Risk;


EXPORT BusnSOSDetails(DATASET(Layouts.BusnLayoutV2) BusnIds ) := FUNCTION
														
riskKey := Address_Attributes.key_AML_addr;	
	
//------------------check for 'good standing' ---------  corp keys
corprec := record
	unsigned4	seq;
	unsigned6 bdid;
	unsigned4	historydate;
	string120 company_name := '';
	string30	corp_key;
end;

corprec get_corpkeys(BusnIds L, corp2.key_Corp_bdid R) := transform
	self.seq := l.seq;
	self.bdid := l.linkedbdid;
	self.corp_key := R.corp_key;
	self.historyDate := l.historyDate;
	self.company_name := l.company_name;
end;

corpkeys := join(ungroup(BusnIds), corp2.key_Corp_bdid,
					keyed(left.linkedBdid = right.bdid),
			  get_corpkeys(LEFT,RIGHT), atmost(250), keep(100));

corprec2 := record
	corp2.key_corp_corpkey;
	unsigned4	seq;
	unsigned4 historyDate;
	string120 company_name := '';
	string corpStatus;
	string lastCorpStatus;
	unsigned4 FirstSeenDate; 
	unsigned4 LastSeenDate; 
	unsigned4 LastReinstatDate; 
	unsigned4 LastDissolvedDate;
	boolean BusnNameChangeSOS;
	boolean contactChangeSOS;
	boolean addressChangeSOS;
	boolean NoSOSFiling;
	unsigned3 CorpStateCount;

end;

corprec2 get_corp_recs(corpkeys L, corp2.key_corp_corpkey R) := transform
  CorpStatusDescUC := stringlib.StringToUpperCase(R.corp_status_desc);
  CorpStatusCd := if (l.corp_key = '', 'X', if (business_header.is_ActiveCorp(r.record_type, R.corp_status_cd, R.corp_status_desc), 'A',
							if (stringlib.stringfind(CorpStatusDescUC, 'GOOD STANDING', 1) != 0, 'A',
							if (stringlib.stringfind(CorpStatusDescUC, 'INACTIVE', 1) != 0, 'I',
							if (stringlib.stringfind(CorpStatusDescUC, 'DISSOLV', 1) != 0, 'D',
							if (stringlib.stringfind(CorpStatusDescUC, 'REINSTAT', 1) != 0, 'R' 
							,'U'))))));
	self.corpStatus := CorpStatusCd;
	self.lastReinstatDate := if(CorpStatusCd = 'R',  r.dt_last_seen, 0);
	self.lastDissolvedDate := if(CorpStatusCd = 'D',  r.dt_last_seen, 0);
	self.LastSeenDate := r.dt_last_seen;
	self.FirstSeenDate := If((integer)r.corp_filing_date = 0, r.dt_first_seen,(integer)r.corp_filing_date) ;
	self.bdid := l.bdid;
	// self.NoSOSFiling := If(r.corp_key = '', true, false);
	self := R;
	self := L;
	self := [];
end;



corprecs := join(corpkeys,  corp2.key_corp_corpkey,
								left.corp_key!='' and 
								keyed(Left.corp_key = right.corp_key) and
								left.bdid = right.bdid and
								(unsigned4) (string8)(left.historydate + '01') >= right.dt_first_seen,
								get_corp_recs(LEFT,RIGHT), 
								ATMOST(keyed(Left.corp_key = right.corp_key),RiskWise.max_atmost), keep(100));

//  Current record status			  
corp_sortDD := dedup(sort(corprecs,seq, bdid, -LastSeenDate, record_type),seq, bdid);

// ditch recs with no SOS till end

AddBusnStatus := join(BusnIds, corp_sortDD,
                      left.seq=right.seq and
											left.linkedBdid=right.bdid,
											transform(Layouts.BusnLayoutV2, 
											          self.lastCorpStatus := right.CorpStatus,
																// self.NoSOSFiling := right.NoSOSFiling,
																self := left));

corp_sort_all := ungroup(sort(corprecs,seq, bdid, -LastSeenDate));



corprec2 rollStatus(corp_sort_all le, corp_sort_all ri) := transform  // change IFs to max  todo  ut fuction for min to exclude zero
	self.lastReinstatDate := Max(le.lastReinstatDate, ri.lastReinstatDate);
	self.lastDissolvedDate := Max(le.lastDissolvedDate, ri.lastDissolvedDate);
	self.LastSeenDate := Max(le.LastSeenDate, ri.LastSeenDate);
	self.FirstSeenDate := ut.Min2(le.FirstSeenDate, ri.FirstSeenDate);
	self := le;
end;
	
FinalStatus := rollup(corp_sort_all, 
                      left.seq=right.seq and
											left.bdid=right.bdid,
											rollStatus(left,right));
											
AddRecentStatus := join(AddBusnStatus, FinalStatus,
                          left.seq = right.seq and
													left.linkedBdid = right.bdid,
													transform(Layouts.BusnLayoutV2,
													          self.lastReinstatDate := right.lastReinstatDate,
																		self.lastDissolvedDate := right.lastDissolvedDate,
																		self.SOSFirstReported := right.firstseendate,
																		self.SOSLastReported := right.LastSeenDate,
																		self  := left),
													left outer);

corplatestchngs := dedup(sort(corprecs,seq, bdid, -LastSeenDate), seq, bdid, keep 2);

// AddrChange
corprec2 checkAddrChng(corplatestchngs le, corplatestchngs ri) := transform
  self.addressChangeSOS     := if(ri.corp_address1_type_cd = 'B' and 
																	(le.corp_address1_line1   <> ri.corp_address1_line1  or
																	le.corp_address1_line2  <>  ri.corp_address1_line2  or
																	le.corp_address1_line3  <>  ri.corp_address1_line3  or
																	le.corp_address1_line4  <>  ri.corp_address1_line4  or
																	le.corp_address1_line5  <>  ri.corp_address1_line5), 1, 0);
	self := le;
end;

AddrChange := rollup(corplatestchngs, 
                      left.bdid=right.bdid,  //  bdid has multi corp keys
											checkAddrChng(left,right));
											
// LastUpdateaddr := dedup(sort(AddrChange, seq, bdid, LastSeenDate), seq, bdid);  // why sort dedup rollup  should only have 1 todo
											
AddBusnAddrChng := join(AddRecentStatus, AddrChange, 
												left.seq=right.seq and
												left.linkedBdid=right.bdid,
												transform(Layouts.BusnLayoutV2,
													      self.addressChangeSOS := right.addressChangeSOS,
														  	self  := left),
													left outer);

// ContactChange
corprec2 checkContactChng(corplatestchngs le, corplatestchngs ri) := transform
	self.contactChangeSOS := if(ri.corp_address1_type_cd = 'T' and 
														(le.corp_address1_line1    <>   ri.corp_address1_line1    or
														le.corp_address1_line2    <>   ri.corp_address1_line2  or
														le.corp_address1_line3    <>  ri.corp_address1_line3  or
														le.corp_address1_line4    <>   ri.corp_address1_line4  or
														le.corp_address1_line5    <>   ri.corp_address1_line5 ), 1, 0);
	self := le;
end;

ContactChange := rollup(corplatestchngs, 
                      left.bdid=right.bdid,
											checkContactChng(left,right));
											
// LastUpdatecontact := dedup(sort(ContactChange, seq, bdid, LastSeenDate), seq, bdid); //? why
											
AddBusnContChng := join(AddBusnAddrChng, ContactChange, 
												left.seq=right.seq and
												left.linkedBdid=right.bdid,
												transform(Layouts.BusnLayoutV2,
													      self.contactChangeSOS := right.contactChangeSOS,
														  	self  := left),
													left outer);
													
// Business name change
corprec2 checkbusnNameChng(corplatestchngs le, corplatestchngs ri) := transform
	self.BusnNameChangeSOS := if(le.corp_legal_name  <>  ri.corp_legal_name, 1, 0);
	self := le;
end;

BusnNameChange := rollup(corplatestchngs, 
                      left.bdid=right.bdid,
											checkbusnNameChng(left,right));
											
// LastUpdateBusnName := dedup(sort(BusnNameChange, seq, bdid, LastSeenDate), seq, bdid);
											
AddBusnNameChng := join(AddBusnContChng, BusnNameChange, 
												left.seq=right.seq and
												left.linkedBdid=right.bdid,
												transform(Layouts.BusnLayoutV2,
													      self.BusnNameChangeSOS := right.BusnNameChangeSOS,
														  	self  := left),
													left outer);

CorpStTbl := table(corp_sort_all(corp_inc_state <> ''), {seq, bdid, corp_inc_state}, seq, bdid, corp_key, corp_inc_state);
CorpStCount := table(ungroup(CorpStTbl), {seq, bdid, unsigned3 CorpStateCount := count(group)}, seq,bdid);


AddBusnCorpSt := join(AddBusnNameChng, CorpStCount, 
												left.seq=right.seq and
												left.linkedBdid=right.bdid,
												transform(Layouts.BusnLayoutV2,
													      self.CorpStateCount := right.CorpStateCount,
														  	self  := left),
													left outer);
	
CorpAddrLocSort :=   dedup(sort(corprecs(corp_addr1_prim_name <> ''), seq, bdid, corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name	, corp_ra_addr_suffix, 
																corp_addr1_postdir, corp_addr1_zip5 ),seq, bdid, corp_addr1_prim_range, corp_addr1_predir, corp_addr1_prim_name	, corp_addr1_addr_suffix, 
																corp_addr1_postdir, corp_addr1_zip5 );

CorpAddrLocCount := table(ungroup(CorpAddrLocSort), {seq, bdid, unsigned3 AddrLocCount := count(group)}, seq,bdid);													
		
		
AddBusnLocCnt := join(AddBusnCorpSt, CorpAddrLocCount, 
												left.seq=right.seq and
												left.linkedBdid=right.bdid,
												transform(Layouts.BusnLayoutV2,
													      self.SOSAddrLocationCount := right.AddrLocCount,
														  	self  := left),
													left outer);		
		
//busn registration  - looking for Registered Agents  

RegAgentsLayout := RECORD
	unsigned4	seq;
	UNSIGNED3	historydate;
	unsigned6  Bdid;
	string120 company_name := '';
	unsigned4  dt_first_seen;
	unsigned4  dt_last_seen;
	string1    recordType;
	string3    Source;
	string120 	RAName := '';
	string10  	prim_range := '';
	string2   	predir := '';
	string28  	prim_name := '';
	string4   	addr_suffix := '';
	string2   	postdir := '';
	string10  	unit_desig := '';
	string8   	sec_range := '';
	string25  	p_city_name := '';
	string2   	st := '';
	string5   	z5 := '';
	BOOLEAN		potentialNIS	:=	FALSE;
	boolean    ShelfBusn  :=	FALSE;
	boolean    HasCurrRA := FALSE;
	boolean    BusRegHit := FALSE;
END;

BusReg := BusReg.key_busreg_company_bdid;   //get emp size

busRegRecs := join(BusnIds, BusReg,  
								Keyed(left.linkedBdid = right.Bdid) and
								(UNSIGNED3)right.dt_first_seen[1..6] < left.historydate, 
               transform(RegAgentsLayout,
							            self.seq := left.seq,
													self.bdid := left.origbdid,
													self.historydate := left.historydate,
													self.company_name := left.company_name,
													self.source := MDR.SourceTools.src_Business_Registration ,
													self.BusRegHit := if(right.br_id <> 0, true, false);
													self.dt_first_seen := (unsigned4)right.dt_first_seen,
													self.dt_last_seen := (unsigned4)right.dt_last_seen,
													self.recordtype := right.record_type,
													self.RAname := right.ra_name,
													self.prim_range := right.ra_prim_range,
													self.predir := right.ra_predir,
													self.prim_name := right.ra_prim_name,
													self.addr_suffix := right.ra_addr_suffix,
													self.postdir := right.ra_postdir,
													self.unit_desig := right.ra_unit_desig,
													self.sec_range := right.ra_sec_range,
													self.p_city_name := right.ra_p_city_name,
													self.st := right.ra_st,
													self.z5 := right.ra_zip,
							            self :=  []),
							 atmost(Keyed(left.linkedBdid = right.Bdid), Riskwise.max_atmost), keep(100)); 
							 
BusRegRAaddr := busRegRecs(prim_name <> '' and z5 <> '');
	

BRCurrRAs := busRegRecs(recordtype = 'C' and (prim_name <> '' or RAname <> ''));

DSbusRegRecs := dedup(sort(busRegRecs, seq, bdid, -dt_last_seen), seq, bdid);
								
// Looking at Registered Agents

	
SOSRAaddr := corprecs(corp_ra_prim_name <> '' and  corp_ra_zip5 <> '');
											
prepSOSRA := project(SOSRAaddr, transform(RegAgentsLayout,
							            self.seq := left.seq,
													self.bdid := left.bdid,
													self.historydate := left.historydate,
													self.source := 'SOS',
													self.company_name := left.company_name,
													self.dt_first_seen := left.dt_first_seen,
													self.dt_last_seen := left.dt_last_seen,
													self.recordType := left.record_type,
													self.RAname := left.corp_ra_name,
													self.prim_range := left.corp_ra_prim_range,
													self.predir := left.corp_ra_predir,
													self.prim_name := left.corp_ra_prim_name,
													self.addr_suffix := left.corp_ra_addr_suffix,
													self.postdir := left.corp_ra_postdir,
													self.unit_desig := left.corp_ra_unit_desig,
													self.sec_range := left.corp_ra_sec_range,
													self.p_city_name := left.corp_ra_p_city_name,
													self.st := left.corp_ra_state,
													self.z5 := left.corp_ra_zip5,
							            self :=  []));	
													
AllRAAddr := dedup(sort((prepSOSRA + BusRegRAaddr), seq, bdid, prim_range, predir, prim_name, addr_suffix, postdir, z5, -dt_last_seen),
											seq, bdid, prim_range, predir,prim_name, addr_suffix, postdir, z5);

SOSCurrRAs := project(corprecs(record_type = 'C' and (corp_ra_prim_name <> '' or corp_ra_name <> '')), 
							transform(RegAgentsLayout,
							            self.seq := left.seq,
													self.bdid := left.bdid,
													self.historydate := left.historydate,
													self.company_name := left.company_name,
													self.source := 'SOS',
													self.dt_first_seen := left.dt_first_seen,
													self.dt_last_seen := left.dt_last_seen,
													self.recordtype := left.record_type,
													self.RAname := left.Corp_ra_name,
													self.prim_range := left.Corp_ra_prim_range,
													self.predir := left.Corp_ra_predir,
													self.prim_name := left.Corp_ra_prim_name,
													self.addr_suffix := left.Corp_ra_addr_suffix,
													self.postdir := left.Corp_ra_postdir,
													self.unit_desig := left.Corp_ra_unit_desig,
													self.sec_range := left.Corp_ra_sec_range,
													self.p_city_name := left.Corp_ra_p_city_name,
													self.st := left.Corp_ra_state,
													self.z5 := left.Corp_ra_zip5,
							            self :=  []));	


RegAgentsLayout  GetRARisk(AllRAAddr le, riskKey ri)  := TRANSFORM

		SELF.seq  := le.seq;
		self.bdid      :=  le.bdid;
		self.historydate := le.historydate;
		self.company_name := le.company_name,
	  self.PotentialNIS			:=	ri.potential_NIS;
	  self.ShelfBusn    :=  ri.potential_shelf;
		self.prim_range := le.prim_range;
		self.predir := le.predir;
		self.prim_name := le.prim_name;
		self.addr_suffix := le.addr_suffix;
		self.postdir := le.postdir;
		self.unit_desig := le.unit_desig;
		self.sec_range := le.sec_range;
		self.p_city_name := le.p_city_name;
		self.st := le.st;
		self.z5 := le.z5;
		self := le;

END;


RAwithRisk := join(AllRAAddr, riskKey, 
		KEYED(trim(LEFT.z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
		KEYED(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.postdir)			= RIGHT.postdir) and
		right.dt_first_seen < left.historydate and
		(Business_Risk.CnameScore(left.company_name, right.cnp_name) between Risk_Indicators.iid_constants.min_score and 100) ,
	GetRARisk(LEFT, RIGHT),
  atmost(		KEYED(trim(LEFT.z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
		KEYED(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.postdir)			= RIGHT.postdir),100 ));
	

RegAgentsLayout  RollRARisk(RAwithRisk le, RAwithRisk ri)  := TRANSFORM

		SELF.seq  := ri.seq;
		self.bdid      :=  ri.bdid;
		self.historydate := ri.historydate;
		self.company_name := ri.company_name,
		self.HasCurrRA  := false;
	  self.PotentialNIS			:=	le.potentialNIS or ri.potentialNIS;
	  self.ShelfBusn    :=  le.ShelfBusn or ri.ShelfBusn;
		self.prim_range := ri.prim_range;
		self.predir := ri.predir;
		self.prim_name := ri.prim_name;
		self.addr_suffix := ri.addr_suffix;
		self.postdir := ri.postdir;
		self.unit_desig := ri.unit_desig;
		self.sec_range := ri.sec_range;
		self.p_city_name := ri.p_city_name;
		self.st := ri.st;
		self.z5 := ri.z5;
		self.dt_first_seen := le.dt_first_seen;
		self.dt_last_seen := le.dt_last_seen;
		self.recordType := le.recordtype;
		self.source := le.source;
END;	
	
RolledRA := rollup(RAwithRisk, left.seq = right.seq and left.bdid = right.bdid, RollRARisk(left,right));

DDCurrRAs := dedup(sort(SOSCurrRAs + BRCurrRAs, seq, bdid), seq, bdid);


// add back all ids that did not have SOS record
AddSOS := join(BusnIds, AddBusnLocCnt, 
												left.seq=right.seq and
												left.linkedBdid=right.linkedBdid,
												transform(Layouts.BusnLayoutV2,
													      self.SOSAddrLocationCount := right.SOSAddrLocationCount,
													      self.CorpStateCount := right.CorpStateCount,
													      self.addressChangeSOS := right.addressChangeSOS,
													      self.lastCorpStatus := right.lastCorpStatus,
																self.NoSOSFiling := IF(right.linkedBdid = 0, TRUE, FALSE),
																self.lastReinstatDate := right.lastReinstatDate,
																self.lastDissolvedDate := right.lastDissolvedDate,
																self.SOSFirstReported := right.SOSFirstReported,
																self.SOSLastReported := right.SOSLastReported,
																self.contactChangeSOS := right.contactChangeSOS,
																self.BusnNameChangeSOS := right.BusnNameChangeSOS,
														  	self  := left),
													left outer);
													
AddRAs  := join(AddSOS, RolledRA,
								left.seq = right.seq and
								left.linkedbdid = right.bdid,
								transform(Layouts.BusnLayoutV2,
														self.RApotentialNIS := right.potentialNIS,
														self.RAShelfBusn := right.ShelfBusn,
														self := left), left outer);
														
AddCurrRAs  := join(AddRAs, DDCurrRAs,
								left.seq = right.seq and
								left.linkedbdid = right.bdid,
								transform(Layouts.BusnLayoutV2,
														self.HasCurrRA := if(right.recordtype = 'C' and (right.prim_name <> '' or right.RAname <> ''), TRUE, FALSE);,
														self := left), left outer);
														
addBusRegHit :=  join(AddCurrRAs, DSbusRegRecs,
												left.seq = right.seq and
												left.linkedbdid = right.bdid,
												transform(Layouts.BusnLayoutV2,
														self.BusRegHit := right.BusRegHit,
														self := left), left outer, keep(1));


							

// output(BusnIds, named('BusnIds'));
// output(corpkeys, named('corpkeys'));
// output(corprecs, named('corprecs'));
// output(corp_sortDD, named('corp_sortDD'));
// output(AddBusnStatus, named('AddBusnStatus'));
// output(corp_sort_all, named('corp_sort_all'));
// output(corplatestchngs, named('corplatestchngs'));
// output(FinalStatus, named('FinalStatus'));
// output(AddRecentStatus, named('AddRecentStatus'));
// output(AddrChange, named('AddrChange'));
// output(LastUpdateaddr, named('LastUpdateaddr'));
// output(AddBusnAddrChng, named('AddBusnAddrChng'));
// output(ContactChange, named('ContactChange'));
// output(LastUpdatecontact, named('LastUpdatecontact'));
// output(AddBusnContChng, named('AddBusnContChng'));
// output(CorpStTbl, named('CorpStTbl'));
// output(CorpStCount, named('CorpStCount'));
// output(CorpAddrLocSort, named('CorpAddrLocSort'));
// output(CorpAddrLocCount, named('CorpAddrLocCount'));
// output(AddBusnLocCnt, named('AddBusnLocCnt'));
// output(AddBusnCorpSt, named('AddBusnCorpSt'));
// output(busRegRecs, named('busRegRecs')); 
// output(BusnEmpcount, named('BusnEmpcount'));
// output(AddBusnEmpCnt, named('AddBusnEmpCnt'));

// output(BusRegRAaddr, named('BusRegRAaddr'));
// output(BRCurrRAs, named('BRCurrRAs'));
// output(SOSRAaddr, named('SOSRAaddr'));
// output(prepSOSRA, named('prepSOSRA'));
// output(AllRAAddr, named('AllRAAddr'));
// output(SOSCurrRAs, named('SOSCurrRAs'));
// output(RAwithRisk, named('RAwithRisk'));
// output(RolledRA, named('RolledRA'));

// output(DDCurrRAs, named('DDCurrRAs'));
// output(AddRAs, named('AddRAs'));
// output(AddCurrRAs, named('AddCurrRAs'));
// output(addBusRegHit, named('addBusRegHit'));


RETURN addBusRegHit;

END;


  