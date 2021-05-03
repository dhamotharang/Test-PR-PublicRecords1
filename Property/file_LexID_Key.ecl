IMPORT $;

df_in := Property.File_Foreclosure_Autokey;

l_slim := RECORD
	UNSIGNED6 did;
	UNSIGNED6 bdid;
	STRING70 fid;
END;

df2 := PROJECT (df_in, TRANSFORM(l_slim, SELF.fid := LEFT.foreclosure_id, SELF := LEFT));
df3 := DEDUP (SORT (df2, RECORD), RECORD);

EXPORT file_LexID_Key := df3;