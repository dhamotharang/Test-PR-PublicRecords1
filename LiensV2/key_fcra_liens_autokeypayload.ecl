import autokeyb2,doxie;
fakepf := liensv2.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,'~thor_data400::key::liensv2::fcra::qa::autokey_payload',plk,'')

export key_fcra_liens_AutokeyPayload := plk;