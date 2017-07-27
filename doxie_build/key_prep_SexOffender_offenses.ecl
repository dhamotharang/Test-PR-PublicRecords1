import doxie_build, sexoffender;

df := file_SO_offenses_keybuilding;

export key_prep_sexoffender_offenses := index(df,{string16 sspk := df.seisint_primary_key},{df},'~thor_data400::key::sexoffender_offenses_' + doxie_build.buildstate + thorlib.wuid());