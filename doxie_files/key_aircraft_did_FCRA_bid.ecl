import faa,doxie,ut;

df := faa.file_aircraft_registration_bldg_bid((integer)did_out > 0);

export key_aircraft_did_fcra_bid := index(df,{unsigned6 did := (integer)df.did_out},{df},
'~thor_data400::key::fcra::aircraft_reg_did_bid_' + doxie.Version_SuperKey);