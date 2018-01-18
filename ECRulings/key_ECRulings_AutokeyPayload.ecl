import autokeyb2, data_services;

fakepf := ECRulings.File_ECRulings_Base;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,
                          data_services.data_location.prefix() + 'thor_data400::key::ECRulings::qa::autokey::payload',
                          plk,'');

export key_ECRulings_AutokeyPayload := plk;