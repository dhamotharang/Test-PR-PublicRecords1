import autokeyb2,doxie;
fakepf := liensv2.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,liensv2.str_AutokeyName+'Payload',plk,'')

export key_liens_AutokeyPayload := plk;