import doxie_build, sexoffender;

df := file_SO_Enh_keybuilding;

export Key_prep_SexOffender_DID := index(df(did != 0),{unsigned6 sdid := (integer)df.did},{df},'~thor_data400::key::sexoffender_did'+ doxie_build.buildstate + thorlib.wuid());