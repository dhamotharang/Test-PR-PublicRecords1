import doxie,ut;

df := faa.searchFile_bid;

export key_aircraft_id_bid := index(df,{aircraft_id},{df},'~thor_Data400::key::aircraft_id_bid_' + doxie.Version_SuperKey);
