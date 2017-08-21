Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export Key_liens_BDID(boolean isFCRA = false) := FUNCTION

get_recs := project(PRTE2_Liens.Files.Party_out,transform(LiensV2.Layout_liens_party_ssn,self:=left));

slim_party := table(get_recs((unsigned6)bdid != 0),
										{get_recs.bdid, get_recs.tmsid, get_recs.rmsid}
										);

slim_dist   := distribute(slim_party,hash(tmsid, rmsid,bdid)); 
slim_sort   := sort(slim_dist, tmsid, rmsid,bdid,local);
slim_dedup  := dedup(slim_sort,tmsid, rmsid,bdid,local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

 RETURN index(slim_dedup,{unsigned6 p_bdid :=(unsigned6)bdid},{TMSID,RMSID},file_prefix + Doxie.Version_SuperKey + '::BDID' );
 
 END;
