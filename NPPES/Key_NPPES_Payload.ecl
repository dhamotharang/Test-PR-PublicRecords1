import autokeyb2,doxie,Data_Services;

fakepf := NPPES.File_SearchAutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,Data_Services.Data_location.Prefix()+'thor_data400::key::nppes::autokey::qa::payload',plk,'');

export Key_Nppes_Payload := plk;
