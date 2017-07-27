import autokeyb2,doxie;

fakepf := dataset([],recordof(Property.File_Foreclosure_Autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,bdid,'~thor_data400::key::foreclosure::autokey::qa::payload',plk,'');

export Key_Foreclosures_Payload := plk;
