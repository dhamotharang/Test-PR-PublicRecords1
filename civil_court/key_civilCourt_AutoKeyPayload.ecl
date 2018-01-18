import autokeyb2,doxie, data_services;

fakepf := dataset([],recordof(civil_court.file_civilCourt_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,
                          data_services.data_location.prefix() + 'thor_data400::key::civil_court::qa::autokey::Payload',plk,'');
                                                                                       
export key_civilCourt_AutoKeyPayload := plk;