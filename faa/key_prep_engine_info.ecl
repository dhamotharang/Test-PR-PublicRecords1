df := dataset('~thor_data400::base::faa_engine_info_BUILDING',layout_engine_info,flat);

export key_prep_engine_info := index(df,{code := df.engine_mfr_model_code},{df},'~thor_data400::key::faa_engine_info' + thorlib.wuid());
