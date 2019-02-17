
EXPORT Fn_Propagate_TMSIDRMSID_Party (DATASET(LiensV2.Layout_TMSIDRMSID_Mappingfile) dslimMain, 
                                      DATASET(liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags) dParty) := FUNCTION
/***********************************************************************************************
DF-24044 - Phase 1 Juli 
This function propogates the oldest TMSID and RMSID to from the main to the party file

LiensV2.file_Hogan_party
thor_data400::base::Liens::party::qa::hogan_full
***********************************************************************************************/

rPartyWithnewIDS := record
string50 NewTMSid;
string50 NewRMSid;
dparty;
end;

rPartyWithnewIDS  tpropagateTMSIDRMSID(dslimmain L,dParty R) := transform
  self.NewTMSid := l.TMSID;
  self.NewRMSid := l.RMSID;
	self := R;
end;

dPartyWithNewIDS := join(distribute(dslimmain,HASH(tmsid_old,rmsid_old)),distribute(dParty,HASH(tmsid,rmsid)),
  											 left.tmsid_old = right.tmsid and 
												 left.rmsid_old = right.rmsid  ,
												 tpropagateTMSIDRMSID(left,right),right outer,local);
															
return dPartyWithNewIDS;
END;