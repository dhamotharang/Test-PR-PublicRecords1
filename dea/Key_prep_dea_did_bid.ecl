import doxie;

export Key_prep_dea_did_bid := index(dea.File_DEA_bid((integer)did != 0),{unsigned6 my_did := (integer)dea.File_Dea_bid.did},{dea.File_Dea_bid},'~thor_data400::key::dea_bid_did' + thorlib.wuid());
