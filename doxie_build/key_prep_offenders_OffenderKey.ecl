import doxie_build;

df := file_offenders_keybuilding;

export key_prep_offenders_OffenderKey := index(df,{string60 ofk := df.offender_key},{df},'~thor_data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate + thorlib.wuid());