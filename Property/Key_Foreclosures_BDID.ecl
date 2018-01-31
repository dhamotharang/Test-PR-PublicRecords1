import doxie, Property, Data_Services;

df_in := Property.File_Foreclosure_Autokey(bdid != 0);

df2 := project (df_in, {unsigned6 bdid, df_in.foreclosure_id});
df3 := dedup (sort (df2, record), record);

EXPORT Key_Foreclosures_BDID := index(df3,{bdid},{string70 fid := foreclosure_id},Data_Services.Data_location.Prefix()+'thor_data400::key::foreclosure_bdid_' + doxie.Version_SuperKey);
