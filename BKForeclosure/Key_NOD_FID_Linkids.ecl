import doxie, ut,BIPV2,fcra;

EXPORT Key_NOD_FID_Linkids(BOOLEAN IsFCRA = FALSE) := FUNCTION

FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
df     := BKForeclosure.File_BK_Foreclosure.fNod(Trim(foreclosure_id, left, right) not in FC_ids);

KeyName      := '~thor_data400::key::BKForeclosure_NOD::';
KeyName_FCRA := '~thor_data400::key::BKForeclosure_NOD::FCRA::';

key_name    := if(isFCRA, KeyName_fcra, KeyName) + 'fid_linkids_' + doxie.Version_SuperKey;

return_file := index(df,{string70 fid := foreclosure_id},{df},key_name);

RETURN(return_file);

END;