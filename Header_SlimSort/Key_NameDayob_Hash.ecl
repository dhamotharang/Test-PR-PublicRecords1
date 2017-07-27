df := header_slimsort.rawfile_nd_hash;

export Key_NameDayob_Hash := index(df,{integer8 hashval := df.hval},{did},'~thor_Data400::key::hss_dayob_Hash' + version);