IMPORT paw, riskwise, risk_indicators, Business_Header, doxie, Business_Header_SS, Suppress, 
Address, header, Relationship, AML;

export IndGetBusnAssoc( DATASET(AML.Layouts.LayoutAMLShellV2) BusnIndv,
											doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION;
//version 2
patw := record
  unsigned4 seq;
	unsigned3 historydate;
	unsigned6 origdid;		
	unsigned6 did;		
	unsigned6 contact_id := 0;
	unsigned8 fp;
	string12 bid := '';
	string10 company_status := '';
	string2 source := '';
	string100 sources := '';	// for use in counting sources
	string100 company_title;  // most recent company title
	unsigned4 First_seen_date := 0;  //(non-dead businesses)
	unsigned2 Business_ct := 0;  // number of different BDIDs worked for
	unsigned2 Dead_business_ct := 0;  // number of different BDIDs worked for that are dead
	unsigned2 Business_active_phone_ct := 0; // number of active business phones
	unsigned2 Source_ct	:= 0;  // number of different PAW sources appeared on
	unsigned4 Last_seen_date := 0;
	unsigned2 BusnExec;
	boolean IsExec;
	
end;


withPAW := join(BusnIndv, paw.Key_Did,
						right.contact_id<>0 and 
						keyed(left.did=right.did), 
						transform(patw,
											self.seq := left.seq;
											self.origdid := left.did;
											self.did := left.did;
											self.historydate := left.historydate;
											self.contact_id := right.contact_id;
											self := []),
						left outer, atmost(riskwise.max_atmost), keep(100));



pawTitle_unsuppressed := join(withPAW, paw.Key_contactid,
						right.contact_id<>0 and 
						right.bdid <> 0 and
						right.company_title <> '' and
						trim(right.company_status)<>'DEAD' and
						// COULD IS EXEC BE ADDED TO FILTER HERE  TODO
						(AMLTitleRank(right.company_title) <= 3) and
						keyed(left.contact_id=right.contact_id) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate, 
						transform({patw, unsigned4 global_sid},
											self.global_sid := right.global_sid;
											self.seq := left.seq;
											self.did := left.did;
											self.origdid := left.origdid;
											self.historydate := left.historydate;								
											self.contact_id := left.contact_id;
											self.bid :=  (string)right.bdid;  // throw in a fake BDID for counting later if the BDID wasn't on the record
											self.company_title := right.company_title;  // most recent company title
											self.Business_ct := if(right.contact_id<>0, 1, 0);  // number of different BDIDs worked for
											self.BusnExec := AMLTitleRank(right.company_title);
											self.IsExec := if(AMLTitleRank(right.company_title) <= 3, true, false);
											self := left;
											),
											// left outer,
						atmost(riskwise.max_atmost), keep(1));  //KEEP 1  - ABOUT THE INDIVIDUAL IF YOU CAN FILTER ON COMPANY TITLE
						
pawTitle := Suppress.Suppress_ReturnOldLayout(pawTitle_unsuppressed, mod_access, patw);
						
BusnExecs := dedup(sort(pawTitle(BusnExec <= 3), seq,did,bid), seq,did,bid);

 AML.Layouts.AMLExecLayoutV2  ExecsOut(BusnExecs le)  := TRANSFORM
  SELF.seq := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origdid  := le.origdid;
	SELF.bdid := (integer)le.bid;
	SELF.Assocdid  := le.did;
	self.relatdid  := le.did;
	SELF.IsExec  := if(le.busnExec <= 3, 1, 0);
	self.LinkedBusn  := false;
	self.RelatDegree := 50;
  SELF := [];
 END;
 
 BusnExecsOut := project(BusnExecs,ExecsOut(left)); 


patw  GetBusnExecs(BusnExecs le, Business_Header.Key_Business_Contacts_BDID ri) := TRANSFORM
    self.seq := le.seq;
		self.did := ri.did;
		self.origdid := le.origdid;
		self.historydate := le.historydate;
		self.bid := le.bid;
		self := [];
END;

// get other DIDs at the same business   can be duplicate DIDs coming back
BusnExecNetw := join(BusnExecs, Business_Header.Key_Business_Contacts_BDID,
											Keyed((integer)left.bid = right.bdid) and 
											left.did <> right.did and right.did <> 0, 
												GetBusnExecs(left, right),atmost(Keyed((integer)left.bid = right.bdid), riskwise.max_atmost), keep(200));  //removed left out
											
DDBusnExecNetw := dedup(sort(BusnExecNetw, seq, origdid, did, bid), seq, origdid, did, bid);

withAssocPAW := join(DDBusnExecNetw, paw.Key_Did,
						right.contact_id<>0 and 
						keyed(left.did=right.did), 
						transform(patw,
											self.seq := left.seq;
											self.did := left.did;
											self.origdid := left.origdid;
											self.historydate := left.historydate;
											self.contact_id := right.contact_id;
											self.bid := left.bid;
											self := []),
						 atmost(riskwise.max_atmost), keep(200));  //removed left outer
											
pawAssocTitle_unsuppressed := join(withAssocPAW, paw.Key_contactid,
						right.contact_id<>0 and 
						right.bdid <> 0 and
						right.bdid = (integer)left.bid and
						right.company_title <> '' and
						(AMLTitleRank(right.company_title) <= 3) and
						trim(right.company_status)<>'DEAD' and
						keyed(left.contact_id=right.contact_id) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate, 
						transform({patw, unsigned4 global_sid},
											self.global_sid := right.global_sid;
											self.seq := left.seq;
											self.did := left.did;
											self.origdid := left.origdid;
											self.historydate := left.historydate;								
											self.contact_id := left.contact_id;
											self.bid :=  (string)right.bdid;  
											self.company_title := right.company_title;  // most recent company title
											self.Business_ct := if(right.contact_id<>0, 1, 0);  // number of different BDIDs worked for
											self.BusnExec := AMLTitleRank(right.company_title);
											self := left;
											),
						atmost(riskwise.max_atmost), keep(200)); 
						
pawAssocTitle := Suppress.Suppress_ReturnOldLayout(pawAssocTitle_unsuppressed, mod_access, patw);

 AssocBusnExecs := dedup(sort(pawAssocTitle, seq,did,bid), seq,did,bid);  
 
 AML.Layouts.AMLExecLayoutV2 AssocExecsOut(AssocBusnExecs le)  := TRANSFORM
  SELF.seq := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origdid  := le.origdid;
	SELF.bdid := (integer)le.bid;
	SELF.Assocdid  := le.did;
	SELF.IsExec  := if(le.busnExec <= 3, 1, 0);
	self.LinkedBusn  := true;
	self.RelatDegree  := 52;
	self.relatdid := le.did;
  SELF := [];
 END;
 
 AssocExecs := project(AssocBusnExecs, AssocExecsOut(left));
 
 DDAssocExecs := dedup(sort(AssocExecs, seq, origdid, assocdid), seq, origdid, assocdid);
 
	//  need parents  and relatives SSN(sharing) for CitizenshipKRI
	DDAssocExecs_dedp := dedup(sort(DDAssocExecs,Assocdid), Assocdid);
	DDAssocExecs_dids := PROJECT(DDAssocExecs_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.Assocdid));

	rellyids := Relationship.proc_GetRelationshipNeutral(DDAssocExecs_dids,TopNCount:=100,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 

 AML.Layouts.AMLExecLayoutV2 Getparents(DDAssocExecs le, Relationship.layout_GetRelationship.interfaceOutputNeutral ri) := TRANSFORM 
	
		self.seq := le.seq;
		self.origdid := le.origdid;
		self.Assocdid := le.Assocdid;
		self.Relatdid := ri.did2;
		self.historydate := le.historydate;
		self.IsExecParent := (ri.title in HEADER.RELATIVE_TITLES.SET_PARENT); 
		self.IsExecRelative := true;
		self.IsExec := false;
		self.RelatDegree  := if(ri.title in HEADER.RELATIVE_TITLES.SET_PARENT, 56, 57);   // 56 =  Assoc Exec parent 57 =  Assoc Exec relative
		self := [];
	END;

 execRelatives := join(DDAssocExecs, rellyids, 
										left.Assocdid = right.did1
										and right.did2 <> 0,
                  Getparents(left, right));

//  need busn addresses
appendsVerify := 'BEST_ALL';

ExecBusn := AssocExecs + BusnExecsOut;	
Linkedprep := project(ExecBusn, transform(Business_Header_SS.Layout_BDID_OutBatch, 
																						self.bdid := left.bdid ,
																						self.seq := left.seq, 
																						self := []));
																						
LinkedprepSD := dedup(sort(Linkedprep, seq, bdid), seq, bdid);

Business_Header_SS.MAC_BestAppend(LinkedprepSD, appendsVerify, appendsVerify, linkedbest, mod_access.DataPermissionMask, mod_access.DataRestrictionMask, true);

AML.Layouts.AMLExecLayoutV2 appendBest(ExecBusn le, linkedbest r) := transform
	SELF.seq := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origdid  := le.origdid;
	self.origbdid := le.origbdid;
	SELF.bdid := le.bdid;
	SELF.Assocdid  := le.Assocdid;
	self.relatdid  := le.relatdid;
	SELF.IsExec  := le.IsExec;
	self.LinkedBusn  := le.LinkedBusn;
	self.RelatDegree := le.RelatDegree;

	self.Company_name := r.best_CompanyName;

	self.fein 		 := r.best_fein;

	cleaned_address := Risk_Indicators.MOD_AddressClean.clean_addr(r.best_addr1, r.best_city, r.best_state, r.best_zip);
	cleanStreetAddr1 := Address.Addr1FromComponents(Address.CleanFields(cleaned_address).Prim_Range, Address.CleanFields(cleaned_address).PreDir,
																										Address.CleanFields(cleaned_address).Prim_Name, Address.CleanFields(cleaned_address).Addr_Suffix,
																										Address.CleanFields(cleaned_address).PostDir, Address.CleanFields(cleaned_address).Unit_Desig,
																										Address.CleanFields(cleaned_address).Sec_Range);

		self.prim_range      := Address.CleanFields(cleaned_address).Prim_Range;
		self.predir          := Address.CleanFields(cleaned_address).Predir;
		self.prim_name       := Address.CleanFields(cleaned_address).Prim_Name;
		self.addr_suffix     := Address.CleanFields(cleaned_address).Addr_Suffix;
		self.postdir         := Address.CleanFields(cleaned_address).Postdir;
		self.unit_desig      := Address.CleanFields(cleaned_address).Unit_Desig;
		self.sec_range       := Address.CleanFields(cleaned_address).Sec_Range;
		self.p_city_name     := Address.CleanFields(cleaned_address).P_City_Name;
		self.st              := Address.CleanFields(cleaned_address).St;
		self.z5              := Address.CleanFields(cleaned_address).Zip;
		self.county          := Address.CleanFields(cleaned_address).County[3..5];
		self.geo_blk         := Address.CleanFields(cleaned_address).Geo_Blk;
		
	self  			 := le;
	self         := [];
end; 


ExecBusnBestAdded := join(ExecBusn, linkedbest, 
											left.seq=right.seq and
											left.bdid = right.bdid, 
											appendBest(left, right), left outer);									
									 
	ExecsFinal := execRelatives + ExecBusnBestAdded;

// output(BusnIndv, named('BusnIndv'));
// output(withPAW, named('withPAW'));
// output(pawTitle, named('pawTitle'));
// output(BusnExecs, named('BusnExecs'));
// output(BusnExecNetw, named('BusnExecNetw'));
// output(DDBusnExecNetw, named('DDBusnExecNetw'));
// output(withAssocPAW, named('withAssocPAW'));
// output(pawAssocTitle, named('pawAssocTitle'));
// output(AssocExecs, named('AssocExecs'));
// output(DDAssocExecs, named('DDAssocExecs'));
// output(execRelatives, named('execRelatives'));
// output(BusnExecsOut, named('IndBusnExecsOut'));

return ExecsFinal ;
END;