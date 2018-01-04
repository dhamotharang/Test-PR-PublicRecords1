import autokeyb2, doxie, FLAccidents, data_services;
fakepf := FLAccidents_Ecrash.File_Ecrash_AutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,
                          data_services.data_location.prefix() + 'thor_data400::key::ecrash::autokey::payload',plk,'');

export Key_ECrash_Payload  := plk;