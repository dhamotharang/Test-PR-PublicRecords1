import faa,doxie,ut;

df := project(faa.file_aircraft_registration_bldg((integer)did_out > 0),
							transform({faa.layout_aircraft_registration_out_slim, unsigned8 __fpos { virtual (fileposition)}}, self := left));

export key_aircraft_did_fcra := index(df,{unsigned6 did := (integer)df.did_out},{df},
'~thor_data400::key::fcra::aircraft_reg_did_' + doxie.Version_SuperKey);