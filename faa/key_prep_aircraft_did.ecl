import ut;
df := faa.searchFile;

export key_prep_aircraft_did := index(df((integer)did_out != 0),{unsigned6 did := (integer)df.did_out},{n_number,aircraft_id},ut.foreign_prod +'thor_data400::key::aircraft_reg_did' + thorlib.wuid());