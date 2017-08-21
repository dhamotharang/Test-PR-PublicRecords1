import autokeyb2,doxie;

fakepf := dataset([],recordof(BKForeclosure.File_Nod_AutoKey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,'~thor_data400::key::bkforeclosure_nod::autokey::qa::payload',plk,'');

export Key_NOD_Payload := plk;
