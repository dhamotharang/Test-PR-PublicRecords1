Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export 	Key_liens_RMSID(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

dist_id		:= distribute(get_recs, hash(TMSID,RMSID));
sort_id 	:= sort(dist_id, TMSID, RMSID, local);
dedup_id	:= dedup(sort_id, TMSID, RMSID, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(dedup_id,{RMSID},{TMSID}, file_prefix + doxie.Version_SuperKey + '::main::RMSID');

END;
