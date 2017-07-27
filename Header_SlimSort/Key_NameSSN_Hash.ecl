df := header_slimsort.rawfile_ns_hash;

export Key_NameSSN_Hash := index(df,{integer8 hashval := df.hval},{did},'~thor_Data400::key::hss_SSN_Hash' + version);