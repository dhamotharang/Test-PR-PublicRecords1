Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export Key_liens_DID(boolean isFCRA = false) := FUNCTION

get_recs := project(PRTE2_Liens.Files.Party_out,transform(LiensV2.Layout_liens_party_ssn,self:=left));

slim_party := table(get_recs((unsigned6)did != 0),
										{get_recs.did, get_recs.tmsid, get_recs.rmsid}
										);

slim_dist   := distribute(slim_party,hash(tmsid, rmsid, did)); 
slim_sort   := sort(slim_dist, tmsid, rmsid, did,local);
slim_dedup  := dedup(slim_sort,tmsid, rmsid, did,local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(slim_dedup,{(unsigned6)did},{TMSID,RMSID},file_prefix + Doxie.Version_SuperKey + '::DID');

END;
