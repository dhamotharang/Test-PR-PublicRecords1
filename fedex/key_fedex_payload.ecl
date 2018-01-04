import autokeyb2,doxie, data_services;

fakepf := dataset([],recordof(fedex.file_fedex_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,
                          data_services.data_location.prefix() + 'thor_data400::key::fedex::autokey::qa::payload',plk,'');

export key_fedex_payload := plk;