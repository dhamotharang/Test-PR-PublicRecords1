df := doxie_build.file_courtoffenses_keybuilding;

export key_prep_courtoffenses := index(df,{ofk := df.offender_key},{df},'~thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate + thorlib.wuid());