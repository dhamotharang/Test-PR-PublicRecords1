import autokeyb2,doxie;

fakepf := dataset([],recordof(BKForeclosure.File_Reo_AutoKey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,'~thor_data400::key::bkforeclosure_reo::autokey::qa::payload',plk,'');

export Key_REO_Payload := plk;


