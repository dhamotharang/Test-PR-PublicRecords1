import autokeyb2,doxie;

fakepf := dataset([],recordof(civil_court.file_civilCourt_autokey));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,'~thor_data400::key::civil_court::qa::autokey::Payload',plk,'');
                                                                                       
export key_civilCourt_AutoKeyPayload := plk;