Import Data_Services, autokeyb2,doxie,ut,FLAccidents;
fakepf := FLAccidents_Ecrash.File_Ecrash_AutoKeyV2;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::autokey::payload',plk,'');

export Key_ECrashV2_Payload  := plk;
