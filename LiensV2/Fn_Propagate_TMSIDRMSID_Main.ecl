import ut;
EXPORT Fn_Propagate_TMSIDRMSID_Main (DATASET(LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main) dMain) := FUNCTION

/***********************************************************************************************
DF-24044 - Project Juli Data enhancement
This function propogates the oldest TMSID to all the records with the same CaselinkID
Then based on the new TMSID the new RMSID is calculated
***********************************************************************************************/

rHoganMainwithNewIds  :=  RECORD
  string50  NewTMSID;
	string50  NewTMSID_final;
	string50  BestEarliestTMSID;
	string50  NewRMSID;
	dMain;
	STRING7   CourtId;	
	STRING45	CaseLinkID_temp	  :=	'';
	STRING45	CaseLinkID_temp2	:=	'';
	// string7   ValidCourtid;
END;

rHoganMainslim :=  RECORD
dMain.TMSID;
dmain.CaseLinkID;
end;

//Get distinct TMSID and earliest CaselinkID
dHoganMain     := Dedup(Sort(Distribute(dMain(TMSID<>'' AND CaseLinkID<>'' ),HASH(TMSID)),
                        TMSID,process_date,orig_filing_date,LOCAL),
                  TMSID,LOCAL);
									
dHoganMainslim := Project(dHoganMain(),rHoganMainslim);

//Extract the court id from TMSID and retain valid ones. Propagate caselink id where missing.
rHoganMainwithNewIds tLiensHoganMainWithCaseLinkID(dHoganMainslim l, dMain r) :=  TRANSFORM

  STRING7 CourtId      :=  r.tmsid[length(TRIM(r.tmsid,LEFT,RIGHT))-6..];
	STRING7 ValidCourtid :=  MAP(regexfind('[A-Z\\.]{6}[A-Z0-9]',CourtId ) and courtid[1..2] in ut.Set_State_Abbrev => CourtId,
	                             CourtId in ['IAO\'BD1','IAO\'BC1'] => CourtId,
															 '');
	  
	self.CourtId          :=  ValidCourtid;
	// self.ValidCourtid  :=  ValidCourtid;
	self.CaseLinkID_temp  :=  l.CaseLinkID; //oldest caselinkid
	self.CaseLinkID_temp2 :=  Map(r.CaseLinkID ='' => l.CaseLinkID, r.CaseLinkID); //populated blank caselinkids with oldest	                             
  self                 :=  r; 
	self                 :=  [];
END;

dHoganMainWCaselink    :=  Join(distribute(dHoganMainslim,HASH(TMSID)),distribute(dMain,HASH(TMSID)),
                                left.TMSID =right.TMSID,
                                tLiensHoganMainWithCaseLinkID(LEFT,RIGHT),Right outer, local
                                );

// output(count(dHoganMainWCaselink(CaseLinkID_temp <> '')));
// output(count(dHoganMainWCaselink(CaseLinkID_temp2 <> '')));
// output(count(dHoganMainWCaselink),named('bef'));

//Group on oldest propagated Caselinkid and court to identify clusters that should have the same tmsid
dCaseLinkIDClusterGrp  :=  GROUP(SORT(DISTRIBUTE(dHoganMainWCaselink(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>''),
                                      HASH( CaseLinkID_temp,CourtID)),
                                 CaseLinkID_temp,CourtID,process_date,orig_filing_date,LOCAL),
                           CaseLinkID_temp,CourtID,LOCAL);
													 

//propagating oldest TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp tPropagateTMSID(dCaseLinkIDClusterGrp l, dCaseLinkIDClusterGrp r) := transform
  self.NewTMSID 			:= MAP (l.process_date ='' => r.TMSID,
	                            l.process_date <= r.process_date =>l.NewTMSID ,
															''
															);
  self := r;
  end;

dHoganMainwithNewTMSID := iterate(dCaseLinkIDClusterGrp,tPropagateTMSID(left,right));		

// All_records := dHoganMainWCaselink(~(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>'')) + dHoganMainwithNewTMSID;
// output(count(dHoganMainWCaselink(~(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>'')));
// output(count(dHoganMainwithNewTMSID),named('step1'));

/*****************************************************************************************************************************/
//Step2
//Group on original Caselinkid and court to identify clusters that should have the same tmsid
dCaseLinkIDClusterGrp2  :=  GROUP(SORT(DISTRIBUTE(dHoganMainwithNewTMSID(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>''),
                                      HASH( CaseLinkID_temp2,CourtID)),
                                 CaseLinkID_temp2,CourtID,process_date,orig_filing_date,LOCAL),
                           CaseLinkID_temp2,CourtID,LOCAL);
													 

//propagating oldest TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp tPropagateTMSID2(dCaseLinkIDClusterGrp2 l, dCaseLinkIDClusterGrp2 r) := transform
  self.NewTMSID_final 			:= MAP (l.process_date ='' => r.NewTMSID,
	                                  l.process_date <= r.process_date =>l.NewTMSID_final ,
															      ''
															     );
  self := r;
  end;

dHoganMainwithNewTMSID2 := iterate(dCaseLinkIDClusterGrp2,tPropagateTMSID2(left,right));	
// output(count(dHoganMainwithNewTMSID2),named('step2'));
/*******************************************************************************************************************/
dhoganMainstep2 := dHoganMainwithNewTMSID2;
//step3 - There are records with multiple caselinks and those caselinks have other tmsid. This step uses the tmsid with max caselinks to unite all
unq_ids:= table(dhoganMainstep2,{tmsid,caselinkid},TMSID,caselinkid,few);

rtabrec := record
unq_ids.tmsid;
caselinkcnt:= count(group);
end;

unq_tmsid:= table(unq_ids,rtabrec,TMSID,few);

rtemp_rec := record
dhoganMainstep2;
unq_tmsid.caselinkcnt;
end;

rtemp_rec getalltherecords(unq_tmsid l ,dhoganMainstep2 r) :=transform
self:= r;
self.caselinkcnt := l.caselinkcnt;
end;
recordsthatdidnotwork  := join(unq_tmsid, dhoganMainstep2() ,
                              left.tmsid = right.tmsid, 
															getalltherecords(left,right),skew(1) );

dCaseLinkIDClusterGrp3  :=  GROUP(SORT(DISTRIBUTE(recordsthatdidnotwork(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>''),
                                       HASH( CaseLinkID_temp2,CourtID)),
                                  CaseLinkID_temp2,CourtID,-caselinkcnt,LOCAL), //use the tmsid that has maximum caselink
                            CaseLinkID_temp2,CourtID,LOCAL);
													 

//propagating TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp3 tPropagateTMSID3(dCaseLinkIDClusterGrp3 l, dCaseLinkIDClusterGrp3 r) := transform
  self.NewTMSID_final 			:= MAP (l.caselinkcnt =0 => r.NewTMSID,
	                                  l.caselinkcnt >= r.caselinkcnt =>l.NewTMSID_final ,
															      ''
															     );
  self := r;
  end;

dHoganMainwithNewTMSID3 := iterate(dCaseLinkIDClusterGrp3,tPropagateTMSID3(left,right));
// output(count(dHoganMainwithNewTMSID3),named('step3'));

/*********************************************************************************************************/

//Step4 - the first two steps in some case result in partial propagation. Use the newtmsid_final that has the maximum caselinkids to unify the cluster.
unq_Newids:= table(dHoganMainwithNewTMSID3,{Newtmsid_final,caselinkid_temp},Newtmsid_final,caselinkid_temp,few);

rNewtabrec := record
unq_Newids.Newtmsid_final;
caselinktempcnt:= count(group);
end;

unq_Newtmsid:= table(unq_Newids,rNewtabrec,Newtmsid_final,few);

rNewtemp_rec := record
dHoganMainwithNewTMSID3;
unq_Newtmsid.caselinktempcnt;
end;

rNewtemp_rec getalltherecords2(unq_Newtmsid l ,dHoganMainwithNewTMSID3 r) :=transform
self:= r;
self.caselinktempcnt := l.caselinktempcnt;
end;
recordsthatdidnotwork2  := join(unq_Newtmsid, dHoganMainwithNewTMSID3 ,
                              left.Newtmsid_final = right.Newtmsid_final,
															getalltherecords2(left,right), skew(1) );

dCaseLinkIDClusterGrp4  :=  GROUP(SORT(DISTRIBUTE(recordsthatdidnotwork2(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>''),
                                       HASH( CaseLinkID_temp,CourtID)),
                                  CaseLinkID_temp,CourtID,-caselinktempcnt,LOCAL),
                            CaseLinkID_temp,CourtID,LOCAL);
													 

//propagating mewtmsid_final with maximun number of caselinks to all the records in the cluster.
dCaseLinkIDClusterGrp4 tPropagateNewTMSID3(dCaseLinkIDClusterGrp4 l, dCaseLinkIDClusterGrp4 r) := transform
  self.NewTMSID_final 			:= MAP (l.caselinktempcnt =0 => r.NewTMSID_final,
	                                  l.caselinktempcnt >= r.caselinktempcnt =>l.NewTMSID_final ,
															      ''
															     );
  self := r;
  end;

dHoganMainwithNewTMSIDFinal := iterate(dCaseLinkIDClusterGrp4,tPropagateNewTMSID3(left,right));


/***************************************************************************************************************************************************/
//Step5
//Populate all the records with the earliest TMSID
dEarliestTmsidPerCluster := dedup(sort(distribute(dHoganMainwithNewTMSIDFinal,HASH(NewTMSID_final)),
                                  NewTMSID_final,orig_filing_date,process_date,tmsid,local),
																	NewTMSID_final,local);
																	
dHoganMainwithNewTMSIDFinal Propagateearliesttmsid(dEarliestTmsidPerCluster l ,dHoganMainwithNewTMSIDFinal r) :=transform
self.BestEarliestTMSID := l.tmsid;
self:= r;
end;
dHoganMainwithBestTMSID  := join(dEarliestTmsidPerCluster, distribute(dHoganMainwithNewTMSIDFinal,HASH(NewTMSID_final)) ,
                              left.Newtmsid_final = right.Newtmsid_final,
															Propagateearliesttmsid(left,right), local );																	
                                 
/***************************************************************************************************************************************************/
//Step6
//Derive the NEW RMSID for the records that got a new TMSID
dHoganMainwithNewTMSIDFinal tDeriveNewRMSID(dHoganMainwithBestTMSID l) := transform
  self.NewRMSID 			:= MAP (L.BestEarliestTMSID <> L.TMSID and trim(L.RMSID)[length(trim(L.RMSID))-1..] =  L.filing_type_id => 'HGR'+trim(L.BestEarliestTMSID[3..])+L.filing_type_id,
	                            L.BestEarliestTMSID <> L.TMSID and trim(L.RMSID)[length(trim(L.RMSID))-1..] <> L.filing_type_id => 'HGR'+trim(L.BestEarliestTMSID[3..])+trim(L.RMSID)[length(trim(L.RMSID))-1..],
															L.RMSID);
  self := L;
  end;
	
dHoganMainwithNewTMSIDRMSID2 := Project(dHoganMainwithBestTMSID,tDeriveNewRMSID(left));	

//combine the changed records and the rest.
All_records2 := dHoganMainWCaselink(~(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>'')) + project(dHoganMainwithNewTMSIDRMSID2,rHoganMainwithNewIds) :Persist('Persist::Liens_Main_with_NewTMSRMSIDs');
// output(count(dHoganMainwithNewTMSIDFinal),named('step4'));
// output(count(dHoganMainwithBestTMSID),named('step5'));
// output(count(All_records(~(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>''))),named('Otherrecs'));
// output(count(dHoganMainwithNewTMSIDRMSID2),named('rmsid'));
// output(count(All_records2),named('after'));
return(All_records2);

End;