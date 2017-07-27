Import Data_Services, autokeyb2,doxie;

fakepf := dataset([],recordof(faa.file_faa_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out,bdid_out,Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::autokey::Payload',plk,'');

export key_faa_AutoKeyPayload := plk;