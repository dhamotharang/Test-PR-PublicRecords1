EXPORT Fn_Propagate_TMSIDRMSID_Main (DATASET(LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main) dMain) := FUNCTION
/***********************************************************************************************
DF-24044 - Phase 1 Juli 
This function propogates the oldest TMSID to all the records with the same CaselinkID
Then based on the new TMSID the new RMSID is calculated
***********************************************************************************************/

rHoganMainwithNewIds  :=  RECORD
	string50  NewTMSID;
	string50  NewRMSID;
	dMain;
	// STRING7   CourtId;	 
END;

rHoganMainwithNewIds tLiensHoganMainWithCaseLinkID(dMain pInput) :=  TRANSFORM
  self.CourtId  :=  pInput.tmsid[LENGTH(TRIM(pInput.tmsid,LEFT,RIGHT))-6..];
  self          :=  pInput; 
	self          :=  [];
END;

dHoganMain :=  PROJECT(dMain,tLiensHoganMainWithCaseLinkID(LEFT));

// output(dSlimHoganMainwithCaseLinkID(~regexfind('[A-Z\\.]{6}[A-Z0-9]',courtid )),named('SampleNoCourtID'));
// output(count(dSlimHoganMainwithCaseLinkID(~regexfind('[A-Z\\.]{6}[A-Z0-9]',courtid ))),named('CntNoCourtID'));
// output(dSlimHoganMainwithCaseLinkID((~regexfind('[A-Z\\.]{6}[A-Z0-9]',courtid )) and caselinkid <> ''),named('SampleNoCourtID_Wcaselink'));
// output(count(dSlimHoganMainwithCaseLinkID((~regexfind('[A-Z\\.]{6}[A-Z0-9]',courtid )) and caselinkid <> '')),named('CntNoCourtID_Wcaselink'));

dCaseLinkIDClusterGrp  :=  GROUP(SORT(DISTRIBUTE(dHoganMain(TMSID<>'' AND CaseLinkID<>'' AND CourtID<>''),
                                      HASH( CaseLinkID,CourtID)),
                                 CaseLinkID,CourtID,process_date,LOCAL),
                           CaseLinkID,CourtID,LOCAL);
													 

//propagating oldest TMSID to all the records in the cluster.
dCaseLinkIDClusterGrp PropagateTMSID(dCaseLinkIDClusterGrp l, dCaseLinkIDClusterGrp r) := transform
  self.NewTMSID 			:= MAP (l.process_date ='' => r.TMSID,
	                            l.process_date <= r.process_date =>l.NewTMSID ,
															r.TMSID
															);
  self := r;
  end;

dHoganMainwithNewTMSID := iterate(dCaseLinkIDClusterGrp,PropagateTMSID(left,right));		

dCaseLinkIDClusterGrp DeriveNewRMSID(dHoganMainwithNewTMSID l) := transform
  self.NewRMSID 			:= MAP (L.NewTMSID <> L.TMSID => 'HGR'+L.NewTMSID[3..]+L.filing_type_id,
															'');
  self := L;
  end;
	
	
//Assign new RMSID
dHoganMainwithNewTMSIDRMSID := Project(dHoganMainwithNewTMSID,DeriveNewRMSID(left));	

Fullset := dHoganMain(~(TMSID<>'' AND CaseLinkID<>'' AND CourtID<>'')) + dHoganMainwithNewTMSIDRMSID;

//Sample after				
// dcaseLinkIDsDups1  :=  HAVING(dSlimHoganMainwithNewTMSID,COUNT(ROWS(LEFT))>3);
// output(count(dSlimHoganMainwithNewTMSID),named('CntclusterTotalAfter'));			
													
// output(count(ungroup(dSlimHoganMainwithNewTMSID(TMSID <> NewTMSID))),named('CntTMSIDSCHanged'));
return(Fullset);
End;