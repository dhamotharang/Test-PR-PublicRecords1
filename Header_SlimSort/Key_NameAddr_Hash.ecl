df := header_slimsort.rawfile_na_hash;

export Key_NameAddr_Hash := index(df,{integer8 hashval := df.hval},{did},'~thor_Data400::key::hss_addr_Hash' + version);