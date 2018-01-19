import autokeyb2,doxie,Data_Services;
fakepf := OIG.File_OIG_KeyBaseTemp;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,Data_Services.Data_location.Prefix()+'thor_data400::key::oig::qa::autokey::payload',plk,'');


export key_OIG_AutokeyPayload := plk;


