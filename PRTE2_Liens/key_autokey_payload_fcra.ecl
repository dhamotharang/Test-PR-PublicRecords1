Import Data_Services, autokeyb2,doxie, liensV2;

fakepf := PRTE2_Liens.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,Data_Services.Data_location.Prefix('Liensv2')+'prte::key::liensv2::fcra::qa::autokey::payload',plk,'')

export key_autokey_payload_fcra := plk;
