import doxie, ut, Property;

df_in := Property.File_Foreclosure_Autokey_bid(bdid != 0);

df2 := project (df_in, {unsigned6 bdid, df_in.foreclosure_id});
df3 := dedup (sort (df2, record), record);

EXPORT Key_Foreclosures_BID := index(df3,{bdid},{string70 fid := foreclosure_id},'~thor_data400::key::foreclosure_bid_' + doxie.Version_SuperKey);
