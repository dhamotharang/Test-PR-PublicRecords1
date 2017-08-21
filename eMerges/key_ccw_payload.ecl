Import Data_Services, autokeyb2,doxie;

fakepf := dataset([],recordof(emerges.file_ccw_searchautokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out6,zero,Data_Services.Data_location.Prefix('emerges')+'thor_data400::key::ccw::qa::autokey::payload',plk,'');

export key_ccw_payload := plk;