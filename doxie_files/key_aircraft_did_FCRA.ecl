import faa,doxie,ut;

df := project(faa.file_aircraft_registration_bldg((integer)did_out > 0),
							transform({faa.layout_aircraft_registration_out_slim, unsigned8 __fpos { virtual (fileposition)}}, self := left));

// DF21779 Blank out specified fields in thor_data400::key::fcra::aircraft_reg_did_qa
ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_aircraft_registration);

export key_aircraft_did_fcra := index(df_cleared,{unsigned6 did := (integer)df_cleared.did_out},{df_cleared},
'~thor_data400::key::fcra::aircraft_reg_did_' + doxie.Version_SuperKey);