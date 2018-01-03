import autokeyb2, doxie, data_services;

fakepf := dataset([],recordof(emerges.file_ccw_searchautokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did_out6,zero,
                          data_services.data_location.prefix() + 'thor_data400::key::ccw::qa::autokey::payload',plk,'');

export key_ccw_payload := plk;