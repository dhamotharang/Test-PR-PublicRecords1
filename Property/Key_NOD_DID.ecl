import doxie, Data_Services;

df_in := Property.File_NOD_Autokey(did != 0);

df2 := project (df_in, {unsigned6 did, df_in.foreclosure_id});
df3 := dedup (sort (df2, record), record);

export Key_NOD_DID := index(df3,{did},{string70 fid := foreclosure_id},Data_Services.Data_location.Prefix()+'thor_data400::key::nod::' + doxie.Version_SuperKey + '::did');
