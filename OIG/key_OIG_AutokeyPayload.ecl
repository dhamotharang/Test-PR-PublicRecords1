Import Data_Services, autokeyb2,doxie, OIG;
fakepf := OIG.File_OIG_KeyBaseTemp;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::oig::qa::autokey::payload',plk,'');


export key_OIG_AutokeyPayload := plk;


