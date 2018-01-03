import autokeyb2,doxie, data_services;

fakepf := DNB_FEINV2.file_SearchAutokey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,intbdid,data_services.data_location.prefix() + 'thor_data400::key::dnbfein::autokey::payload',plk,'')

export key_DNBFein_AutokeyPayload := plk;