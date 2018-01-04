import autokeyb2, doxie, data_services;

fakepf := FLAccidents.File_ntlcrash_AutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,
                          data_services.data_location.prefix() + 'thor_data400::key::ntlcrash::autokey::payload',plk,'');

export Key_ntlCrash_Payload  := plk;