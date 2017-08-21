import doxie, Data_Services,fcra;

export Key_NOD_DID(boolean IsFCRA = false) := function

df_in := BKForeclosure.File_BK_Foreclosure.fNod(did != 0);

df2 := project (df_in, {unsigned6 did, df_in.foreclosure_id});
df3 := dedup (sort (df2, record), record);

KeyName      := '~thor_data400::key::BKForeclosure_NOD::';
KeyName_FCRA := '~thor_data400::key::BKForeclosure_NOD::FCRA::';

key_name := if(isFCRA, KeyName_fcra, KeyName) + 'did_' + doxie.Version_SuperKey;

return_file := index(df3,{did},{string70 fid := foreclosure_id},key_name);

return(return_file);

end;