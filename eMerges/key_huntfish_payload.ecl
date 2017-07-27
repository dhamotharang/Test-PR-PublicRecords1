Import Data_Services, autokeyb2,doxie;

fakepf := dataset([],recordof(emerges.file_huntfish_searchautokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::hunting_fishing::qa::autokey::payload',plk,'');

export key_huntfish_payload := plk;