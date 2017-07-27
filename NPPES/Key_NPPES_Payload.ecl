import autokeyb2,doxie;

fakepf := NPPES.File_SearchAutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,'~thor_data400::key::nppes::autokey::qa::payload',plk,'');

export Key_Nppes_Payload := plk;
