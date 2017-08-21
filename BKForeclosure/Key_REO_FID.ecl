import doxie, Data_Services,fcra;

export Key_REO_FID(boolean IsFCRA = false) := function

FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
df := BKForeclosure.File_BK_Foreclosure.fReo(Trim(foreclosure_id, left, right) not in FC_ids);


KeyName      := '~thor_data400::key::BKForeclosure_REO::';
KeyName_FCRA := '~thor_data400::key::BKForeclosure_REO::FCRA::';

key_name := if(isFCRA, KeyName_fcra, KeyName) + 'fid_' + doxie.Version_SuperKey;

return_file := index(df,{STRING70 fid := foreclosure_id},{df},key_name);

return(return_file);

end;