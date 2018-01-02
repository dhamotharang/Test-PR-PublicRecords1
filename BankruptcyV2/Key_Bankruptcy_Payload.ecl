import autokeyb2,doxie, data_services;
fakepf := bankruptcyv2.file_search_autokey();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,data_services.data_location.prefix('bankruptcyv2') + 'thor_data400::key::bankruptcy::autokey::payload',plk,'');


export Key_Bankruptcy_Payload := plk;