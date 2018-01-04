import autokeyb2, doxie, data_services;

fakepf := dataset([],recordof(DNB.File_DNB_autoKey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,bdid, data_services.data_location.prefix() + 'thor_data400::key::dnb::autokey::qa::payload',plk,'');

export Key_DNB_Payload := plk;