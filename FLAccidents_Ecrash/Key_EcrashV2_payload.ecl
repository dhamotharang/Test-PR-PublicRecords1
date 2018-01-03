import autokeyb2, doxie, FLAccidents, data_services;
fakepf := FLAccidents_Ecrash.File_Ecrash_AutoKeyV2;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,
                          data_services.data_location.prefix() + 'thor_data400::key::ecrashV2::autokey::payload',plk,'');

export Key_ECrashV2_Payload  := plk;