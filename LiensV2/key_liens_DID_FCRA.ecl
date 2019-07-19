import liensv2, Doxie, Data_Services, vault, _control;

get_recs := project(LiensV2.file_liens_party,transform(liensv2.layout_liens_party_ssn,self:=left));;

slim_party := table(get_recs((unsigned6)did != 0), {get_recs.did,
                               get_recs.tmsid,
						       get_recs.rmsid});

slim_dist   := distribute(slim_party, hash(tmsid, rmsid, did));
slim_sort   := sort(slim_dist, tmsid, rmsid, did, local);
slim_dedup  := dedup(slim_sort, tmsid, rmsid, did, local);


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_liens_DID_FCRA := vault.LiensV2.key_liens_DID_FCRA;

#ELSE
export key_liens_DID_FCRA := index(slim_dedup,{unsigned6 did := (unsigned6)did},{TMSID,RMSID},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::DID_' + doxie.Version_SuperKey);

#END;

