import doxie, ut, Property;

df_in := Property.File_NOD_Autokey(bdid != 0);

df2 := project (df_in, {unsigned6 bdid, df_in.foreclosure_id});
df3 := dedup (sort (df2, record), record);

export Key_NOD_BDID := index(df3,{bdid},{string70 fid := foreclosure_id},'~thor_data400::key::nod::' + doxie.Version_SuperKey + '::bdid');