import doxie;

df        := dataset('~thor_data400::base::superior_liens_did', liens_superior.Layout_Superior_Liens, flat);
df_filter := df((integer)trim(did,left,right) <> 0);

df_filter_sort := sort(df_filter, LNI, did);
df_filter_dedup := dedup(df_filter_sort, LNI, did);

export key_did := index(df_filter_dedup, {unsigned6 did := (integer)did}, {LNI},'~thor_data400::key::superior_liens_did_' + doxie.Version_SuperKey);
