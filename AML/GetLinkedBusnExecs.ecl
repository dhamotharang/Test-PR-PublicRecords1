Import business_header, PAW, RiskWise, doxie, Business_Risk, Business_Header_SS, Risk_Indicators, Address, Header,Relationship, Suppress, AML;

EXPORT GetLinkedBusnExecs(DATASET(AML.Layouts.BusnLayoutV2) BusnIds, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

gScore(UNSIGNED1 i) := i BETWEEN 5 AND 79;



//version 2
patw := record
  unsigned4 seq;
	unsigned4 historydate;
	unsigned6 origbdid;	
	unsigned6 bdid;	
	boolean linkedbusn;
	unsigned3 	BusnRelatDegree := 0;
	unsigned6 did;		
	unsigned6 contact_id := 0;
	string10 company_status := '';
	qstring100 company_title;  // most recent company title
	unsigned4 First_seen_date := 0;  
	unsigned4 Last_seen_date := 0;
	unsigned2 BusnExec;
	boolean IsExec;
	
end;



// Related Business
Layouts.BusnExecsLayoutV2 check_rels(BusnIds L, business_header.Key_Business_Relatives R) := transform
  
	self.LinkedBusn :=  true; 
  self.bdid      := r.bdid2;
  self.Origbdid  := l.origbdid;
	self.seq       := l.seq;
	self.historydate := l.historydate;
	self.relatdegree := AMLConstants.LnkdBusnDegree;  //20
	self.OrigBDIDCoName := l.company_name;

	self := [];
end;
	
wLinkedBusn := join(BusnIds, business_header.key_business_relatives,
		
				keyed(left.origbdid = right.bdid1) and 
						right.bdid2 <> 0 
						and 									 
						(right.business_registration  or 
						 right.corp_charter_number or
						right.dca_company_number or
						right.fein or 
						right.name_address or
						right.phone or
						right.duns_number or
						right.duns_tree or
						right.name or
						right.name_phone),		
						check_rels(LEFT,RIGHT),  
						ATMOST(keyed(left.origbdid = right.bdid1), riskwise.max_atmost), keep(200));						

appendsVerify := 'BEST_ALL';


Linkedprep := project(wLinkedBusn, transform(Business_Header_SS.Layout_BDID_OutBatch, 
																						self.bdid := left.bdid ,
																						self.seq := left.seq, 
																						self := []));
																						
LinkedprepSD := dedup(sort(Linkedprep, seq, bdid), seq, bdid);


Business_Header_SS.MAC_BestAppend(LinkedprepSD, appendsVerify, appendsVerify, linkedbest, mod_access.DataPermissionMask, mod_access.DataRestrictionMask, true);


Layouts.BusnExecsLayoutV2 appendBest(wLinkedBusn l, linkedbest r) := transform
  self.origbdid 		 := l.origbdid;
	self.bdid          := r.bdid;
	self.seq           := l.seq;
	self.linkedbusn    := l.linkedbusn;
	self.isexec        := l.isexec;
	self.score 		 			:= r.score;
	self.account        := l.account;
	self.Bestaddr 		 := r.best_addr1;
	self.Bestcity 		 := r.best_city;
	self.Beststate 	 	:= r.best_state;
	self.Bestzip 		 := r.best_zip;
	self.BestZip4		 := r.best_zip4;
	self.bestCompanyName := r.best_CompanyName;
	self.Company_name := r.best_CompanyName;
	self.Bestphone		 := r.best_phone ;
	self.Bestfein 		 :=  r.best_fein;
	self.historydate := l.historydate;
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(r.best_addr1, r.best_city, r.best_state, r.best_zip);
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
		self.zip4            := Address.CleanFields(cleaned_address).Zip4;
		self.lat             := Address.CleanFields(cleaned_address).Geo_Lat;
		self.long            := Address.CleanFields(cleaned_address).Geo_Long;
		self.addr_type       := Risk_Indicators.iid_constants.override_addr_type(cleanStreetAddr1, Address.CleanFields(cleaned_address).Rec_Type[1], Address.CleanFields(cleaned_address).Cart);
		self.addr_status     := Address.CleanFields(cleaned_address).Err_Stat;	
		self.county          := Address.CleanFields(cleaned_address).County[3..5];
		self.geo_blk         := Address.CleanFields(cleaned_address).Geo_Blk;
		
	self  			 := l;
	self         := [];
end; 


LinkedBestAdded := join(wLinkedBusn, linkedbest, 
											left.seq=right.seq and
											left.bdid = right.bdid, 
											appendBest(left, right), left outer);

//keep top 100 linked business - has best fein,  best phone

SortLinked := sort(LinkedBestAdded(bestaddr <> ''), seq,if(bestfein ='', '999999999', bestfein), if(bestphone = '', '9999999999', bestphone));

TopLinked := dedup(SortLinked, seq, keep(100));


Layouts.BusnExecsLayoutV2 SubjectBusn(BusnIds L) := transform
	self.LinkedBusn :=  false; 
  self.bdid      := l.origbdid;
  self.Origbdid  := l.origbdid;
	self.seq       := l.seq;
	self.historydate := l.historydate;
	self.RelatDegree := 10;
	self := l;
	self := [];
end;


SubBusn  :=  project(BusnIds, SubjectBusn(left));
										 
AllBDIDs := SubBusn + TopLinked;

// get people assoc with business

patw  GetBusnExecs(AllBDIDs le, Business_Header.Key_Business_Contacts_BDID ri) := TRANSFORM
    self.seq := le.seq;
		self.did := ri.did;
		self.origbdid := le.origbdid;
		self.historydate := le.historydate;
		self.bdid := le.bdid;
		self.LinkedBusn := le.linkedbusn;	
		self.BusnRelatDegree := if(le.RelatDegree = AMLConstants.SubjBusnDegree, AMLConstants.execSubjBsnDegree, if(le.RelatDegree = AMLConstants.LnkdBusnDegree, AMLConstants.execsLnkdBusnDegree, 99));
		self := le;
		self := [];
END;

// get other DIDs at the sbuject business and linked
RelatBusncontacts := join(AllBDIDs, Business_Header.Key_Business_Contacts_BDID,
											keyed((integer)left.bdid = right.bdid) and 
											 right.did <> 0  and 
											 right.dt_first_seen  <= (unsigned4)(string)(left.historydate + '01'), 
												GetBusnExecs(left, right),
												ATMOST(keyed((integer)left.bdid = right.bdid), riskwise.max_atmost), keep(50));

SDRelatBusnCont := dedup(sort(RelatBusncontacts, seq, origbdid, bdid, did), seq, origbdid, bdid, did); 

ContactsPAW := join(SDRelatBusnCont, paw.Key_Did,
						right.contact_id<>0 and 
						keyed(left.did=right.did), 
						transform(patw,
											self.seq := left.seq;
											self.origbdid := left.origbdid;
											self.bdid := left.bdid;
											self.did := left.did;
											self.historydate := left.historydate;
											self.contact_id := right.contact_id;
											self.LinkedBusn := left.linkedbusn;
											self.BusnRelatDegree := left.BusnRelatDegree;
											self := []),
											left outer, atmost(riskwise.max_atmost), keep(200));

ddContactsPaw := dedup(sort(ContactsPAW, seq, origbdid, bdid, did, contact_id), seq, origbdid, bdid, did, contact_id);

pawTitle_unsuppressed := join(ddContactsPaw, paw.Key_contactid,
						right.contact_id<>0 and 
						right.bdid <> 0 and
						right.company_title <> '' and
						trim(right.company_status)<>'DEAD' and
						(AMLTitleRank(right.company_title) <= 3) and
						keyed(left.contact_id=right.contact_id) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate, 
						transform({patw, unsigned4 global_sid},
											self.global_sid := right.global_sid;
											self.seq := left.seq;
											self.origbdid := left.origbdid;
											self.bdid := left.bdid;
											self.did := left.did;
											self.LinkedBusn := left.linkedbusn;
											self.historydate := left.historydate;							
											self.contact_id := left.contact_id;
											self.company_title := right.company_title;  // most recent company title
											self.BusnExec := AMLTitleRank(right.company_title);
											self.IsExec := if(AMLTitleRank(right.company_title) <= 3, 1, 0);
											self.BusnRelatDegree := left.BusnRelatDegree;
											self := left;
											),
											// left outer,
											atmost(riskwise.max_atmost), keep(50));
						
pawTitle := Suppress.Suppress_ReturnOldLayout(pawTitle_unsuppressed, mod_access, patw);
						
BusnExecs := sort(pawTitle, seq,origbdid,bdid,did);

DDBusnExecs := dedup(BusnExecs, seq,origbdid,bdid,did);


 Layouts.BusnExecsLayoutV2  ExecsOut(DDBusnExecs le)  := TRANSFORM
  SELF.seq := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origbdid  := le.origbdid;
	SELF.bdid := le.bdid;
	SELF.did  := le.did;
	SELF.relatdid  := le.did;
	SELF.LinkedBusn := le.linkedbusn;
	self.IsExec   := le.IsExec;
	self.relatdegree := le.busnrelatdegree;
	self := le;
  SELF := [];
 END;
 
 BusnExecsOut := project(DDBusnExecs,	ExecsOut(left)); 

//get all the bdid related to busn execs


ContactsLayout := Record
  unsigned4		seq := 0;
	unsigned4		historydate;
	unsigned6   OrigBdid;
	unsigned6 	bdid := 0;
	unsigned6 	did := 0;
	unsigned6 	fp_id := 0;
	
END;

ExecRelatBusn := join(DDBusnExecs, Business_Header.Key_Business_Contacts_DID,
											Keyed((integer)left.did = right.did) and 
												right.fp <> 0, 
												transform(ContactsLayout,
												           self.seq := left.seq;
																	 self.historydate := left.historydate;
																	 self.OrigBdid := left.origbdid;
																	 self.bdid := 0;
																	 self.did := left.did;
																	 self.fp_id := right.fp;), 
												left outer,
												ATMOST(Keyed((integer)left.did = right.did),riskwise.max_atmost), keep(50));
												
ddExecRelatBusn := dedup(sort(ExecRelatBusn, seq, origbdid, did, fp_id), seq, origbdid, did, fp_id); 

Layouts.BusnExecsLayoutV2 AddExecbdids(ddExecRelatBusn L, Business_Header.Key_Business_Contacts_FP R) := transform
  
	self.LinkedBusn :=  true; 
  self.bdid      := r.bdid;
	self.did       := l.did;
  self.Origbdid  := l.OrigBdid;
	self.seq       := l.seq;
	self.historydate := l.historydate;
	self.relatdid := l.did;
	self.relatdegree := AMLConstants.relatedbusnDegree;
	self.isexec := true;
	self := [];
end;
												
getbdids := join(ddExecRelatBusn, Business_Header.Key_Business_Contacts_FP,
									keyed(left.fp_id = right.fp)  and
									right.bdid <> 0 and
									right.bdid <> left.OrigBdid and
									AMLTitleRank(right.company_title) <= 3,
									AddExecbdids(left,right), 
									atmost(keyed(left.fp_id = right.fp), riskwise.max_atmost), keep(50));
	
DDBexecBdids := dedup(sort(getbdids(bdid <> 0), seq,origbdid,bdid), seq,origbdid,bdid);	



execBdidsprep := project(DDBexecBdids, transform(Business_Header_SS.Layout_BDID_OutBatch, 
																						self.bdid := left.bdid ,
																						self.seq := left.seq, 
																						self := []));

Business_Header_SS.MAC_BestAppend(execBdidsprep, appendsVerify, appendsVerify, ExecBdidbest, mod_access.DataPermissionMask, mod_access.DataRestrictionMask, true);


Layouts.BusnExecsLayoutV2 appendBest2(DDBexecBdids l, ExecBdidbest r) := transform
  self.origbdid 		 := l.origbdid;
	self.bdid          := r.bdid;
	self.seq           := l.seq;
	self.linkedbusn    := l.linkedbusn;
	self.isexec        := l.isexec;
	self.score 		 			:= r.score;
	self.account        := l.account;
	self.Bestaddr 		 := r.best_addr1;
	self.Bestcity 		 := r.best_city;
	self.Beststate 	 	:= r.best_state;
	self.Bestzip 		 := r.best_zip;
	self.BestZip4		 := r.best_zip4;
	self.bestCompanyName := r.best_CompanyName;
	self.Company_name := r.best_CompanyName;
	self.Bestphone		 := r.best_phone;
	self.Bestfein 		 := r.best_fein;
	self.LinkBusnNmScore 	:= Business_Risk.CnameScore(l.OrigBDIDCoName, r.best_CompanyName); // need to know origbdid company name
	self.historydate := l.historydate;
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(r.best_addr1, r.best_city, r.best_state, r.best_zip);
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
		self.zip4            := Address.CleanFields(cleaned_address).Zip4;
		self.lat             := Address.CleanFields(cleaned_address).Geo_Lat;
		self.long            := Address.CleanFields(cleaned_address).Geo_Long;
		self.addr_type       := Risk_Indicators.iid_constants.override_addr_type(cleanStreetAddr1, Address.CleanFields(cleaned_address).Rec_Type[1], Address.CleanFields(cleaned_address).Cart);
		self.addr_status     := Address.CleanFields(cleaned_address).Err_Stat;	
		self.county          := Address.CleanFields(cleaned_address).County[3..5];
		self.geo_blk         := Address.CleanFields(cleaned_address).Geo_Blk;
		
	self  			 := l;
	self         := [];
end; 


execBdidsBestAdded := join(DDBexecBdids, ExecBdidbest, 
											left.seq=right.seq and
											left.bdid = right.bdid, 
											appendBest2(left, right), left outer);
											
 everybody := execBdidsBestAdded  + AllBDIDs + BusnExecsOut;
 
 EverybodySD := dedup(sort(everybody, seq, origbdid, bdid,did, relatdegree), seq, origbdid, bdid,did);
 
 //exec relatives
 
	SDExecs := dedup(sort(EverybodySD(relatdegree in [AMLConstants.execSubjBsnDegree,AMLConstants.execsLnkdBusnDegree]), seq, did), seq, did);
	
	SDExecs_dedp := dedup(sort(SDExecs,did), did);
	SDExecs_dids := PROJECT(SDExecs_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

	rellyids := Relationship.proc_GetRelationshipNeutral(SDExecs_dids,TopNCount:=50,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 

	Layouts.BusnExecsLayoutV2  Getparents(EverybodySD le, Relationship.layout_GetRelationship.interfaceOutputNeutral ri) := TRANSFORM
		
			self.seq := le.seq;
			self.Origbdid := le.Origbdid;
			self.bdid := le.bdid;
			self.did := le.did;
			self.relatdid := ri.did2;
			self.historydate := le.historydate;
			self.IsExec := false;
			self.RelatDegree  := if(ri.title in Header.relative_titles.Set_Parent, AMLConstants.ExecParentsdegree, AMLConstants.execRelativesDegree);
			self := [];
	END;	

	//  need parents  and relatives SSN(sharing) for CitizenshipKRI
 execRelatives := join(SDExecs, rellyids, 
										left.did = right.did1
										and right.did2 <> 0
										and  (right.title in Header.relative_titles.set_Parent),
                   Getparents(left, right));

 Finalout := ungroup(EverybodySD + execRelatives);

// output(wLinkedBusn, named('wLinkedBusn'));
// output(LinkedBestAdded, named('LinkedBestAdded'));
// output(SortLinked, named('SortLinked'));
// output(TopLinked, named('TopLinked'));

 RETURN Finalout;

END;
