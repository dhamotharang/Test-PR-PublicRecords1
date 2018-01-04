import doxie_build, data_services;

df := file_SO_Enh_keybuilding;

export Key_prep_SexOffender_SPK := index(df,
                                         {string16 sspk := df.seisint_primary_key},
                                         {df},
                                         data_services.data_location.prefix() + 'thor_data400::key::sexoffender_spk'+ doxie_build.buildstate + thorlib.wuid());