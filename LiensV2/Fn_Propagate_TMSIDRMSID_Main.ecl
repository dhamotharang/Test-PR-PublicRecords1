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
									
dHoganMainslim := Project(dHoganMain,rHoganMainslim);

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

//Group on oldest propagated Caselinkid and court to identify clusters that should have the same tmsid
dCaseLinkIDClusterGrp  :=  GROUP(SORT(DISTRIBUTE(dHoganMainWCaselink(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>''),
                                      HASH( CaseLinkID_temp,CourtID)),
                                 CaseLinkID_temp,CourtID,process_date,orig_filing_date,LOCAL),
                           CaseLinkID_temp,CourtID,LOCAL);
													 

//propagating oldest TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp tPropagateTMSID(dCaseLinkIDClusterGrp l, dCaseLinkIDClusterGrp r) := transform
  self.NewTMSID 			:= MAP (l.process_date ='' => r.TMSID,
	                            l.process_date <= r.process_date =>l.NewTMSID ,
															r.TMSID
															);
  self := r;
  end;

dHoganMainwithNewTMSID := iterate(dCaseLinkIDClusterGrp,tPropagateTMSID(left,right));		
All_records := dHoganMainWCaselink(~(TMSID<>'' AND CaseLinkID_temp<>'' AND CourtID<>'')) + dHoganMainwithNewTMSID;

//Group on original Caselinkid and court to identify clusters that should have the same tmsid
dCaseLinkIDClusterGrp2  :=  GROUP(SORT(DISTRIBUTE(All_records(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>''),
                                      HASH( CaseLinkID_temp2,CourtID)),
                                 CaseLinkID_temp2,CourtID,process_date,orig_filing_date,LOCAL),
                           CaseLinkID_temp2,CourtID,LOCAL);
													 

//propagating oldest TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp tPropagateTMSID2(dCaseLinkIDClusterGrp2 l, dCaseLinkIDClusterGrp2 r) := transform
  self.NewTMSID_final 			:= MAP (l.process_date ='' => r.NewTMSID,
	                                  l.process_date <= r.process_date =>l.NewTMSID_final ,
															      r.NewTMSID
															     );
  self := r;
  end;

dHoganMainwithNewTMSID2 := iterate(dCaseLinkIDClusterGrp2,tPropagateTMSID2(left,right));	


//Derive the NEW RMSID for the records that got a new TMSID
dCaseLinkIDClusterGrp tDeriveNewRMSID(dHoganMainwithNewTMSID2 l) := transform
  self.NewRMSID 			:= MAP (L.NewTMSID_final <> L.TMSID => 'HGR'+trim(L.NewTMSID_final[3..])+L.filing_type_id,
															L.RMSID);
  self := L;
  end;
	
dHoganMainwithNewTMSIDRMSID2 := Project(dHoganMainwithNewTMSID2,tDeriveNewRMSID(left));	

//combine the changed records and the rest.
dFullset := All_records(~(TMSID<>'' AND CaseLinkID_temp2<>'' AND CourtID<>'')) + dHoganMainwithNewTMSIDRMSID2 :Persist('Persist::Liens_Main_with_NewTMSRMSIDs1');


return(dFullset);
End;