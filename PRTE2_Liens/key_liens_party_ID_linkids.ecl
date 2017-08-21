Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

get_recs := PRTE2_Liens.Files.Party_out; //future use. Key is currently blank in PRTE

EXPORT key_liens_party_ID_linkids := index(get_recs,{TMSID,RMSID},{get_recs},
																						Constants.KEY_PREFIX + doxie.Version_SuperKey + '::party::tmsid.rmsid_linkids');