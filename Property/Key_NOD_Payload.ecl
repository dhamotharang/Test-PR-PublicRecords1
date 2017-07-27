import autokeyb2,doxie;

fakepf := dataset([],recordof(Property.File_NOD_Autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,'~thor_data400::key::nod::autokey::qa::payload',plk,'');

export Key_NOD_Payload := plk;
