import autokeyb2,data_services;

fakepf := dataset([],Layouts_Voters.Layout_Voters_Autokeys);

//t := VotersV2.Constants(VotersV2.Version).AutoKey_keyname;
t := data_services.data_location.prefix('Voter') + 'thor_data400::key::voters::autokey::qa::';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,t+'Payload',plk,'')

export Key_Voters_AutoKeyPayload := plk;
