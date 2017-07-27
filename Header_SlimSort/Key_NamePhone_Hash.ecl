df := header_slimsort.rawfile_np_hash;

export Key_NamePhone_Hash := index(df,{integer8 hashval := df.hval},{did},'~thor_Data400::key::hss_phone_Hash' + version);