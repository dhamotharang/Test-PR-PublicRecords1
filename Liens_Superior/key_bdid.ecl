import doxie;

df        := dataset('~thor_data400::base::superior_liens_did', liens_superior.Layout_Superior_Liens, flat);
df_filter := df(bdid <> '');

export key_bdid := index(df_filter, {unsigned6 bdid := (integer)bdid}, {LNI},'~thor_data400::key::superior_liens_bdid_' + doxie.Version_SuperKey);
