Import Data_Services, autokeyb2,doxie;

fakepf := dataset([],recordof(faa.file_faa_airmen_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out6,zero,Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::airmen::autokey::payload',plk,'');

export key_faa_airmen_Autokeypayload := plk;