Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export 	Key_liens_party_ID(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Party_out;

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(get_recs,{tmsid,RMSID},{get_recs},file_prefix + doxie.Version_SuperKey + '::party::TMSID.RMSID');

END;