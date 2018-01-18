import autokeyb2,doxie, data_services;
fakepf := bankruptcyv3.file_search_autokey();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,data_services.data_location.prefix('bankruptcyv3') + 'thor_data400::key::bankruptcy::autokey::fcra::payload',plk,'');


export Key_BankruptcyV3_Payload := plk;