import autokeyb2,domains, data_services;

fakepf := dataset([],recordof(domains.file_whois_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid, data_services.data_location.prefix() + 'thor_data400::key::internetservices::qa::autokey::Payload',plk,'');
                

export key_internetservices_AutoKeyPayload := plk;