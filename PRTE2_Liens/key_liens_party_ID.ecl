Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export 	Key_liens_party_ID(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Party_out;
ut.MAC_CLEAR_FIELDS(get_recs, get_recs_cleared, prte2_liens.Constants.fields_to_clear_party_id_fcra);

dsFile := if(ISFCRA, get_recs_cleared, get_recs);

dist_id := distribute(dsFile, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);



RETURN index(sort_id,{tmsid,RMSID},{sort_id},file_prefix + doxie.Version_SuperKey + '::party::TMSID.RMSID');

END;

