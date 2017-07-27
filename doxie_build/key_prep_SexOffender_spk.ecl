import doxie_build, sexoffender;

df := file_SO_Enh_keybuilding;

export Key_prep_SexOffender_SPK := index(df,{string16 sspk := df.seisint_primary_key},{df},'~thor_data400::key::sexoffender_spk'+ doxie_build.buildstate + thorlib.wuid());