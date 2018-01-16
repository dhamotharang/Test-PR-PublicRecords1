import doxie, Data_Services;

df        := dataset('~thor_data400::base::superior_liens', liens_superior.Layout_Superior_Liens, flat);
df_filter := df(bdid <> '');

export key_bdid := index(df_filter, {unsigned6 bdid := (integer)bdid}, {LNI},Data_Services.Data_location.Prefix()+'thor_data400::key::superior_liens_bdid_' + doxie.Version_SuperKey);
