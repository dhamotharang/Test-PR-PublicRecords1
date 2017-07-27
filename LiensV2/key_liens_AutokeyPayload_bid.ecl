import autokeyb2,doxie;
fakepf := project(liensv2.file_SearchAutokey_bid(dataset([],LiensV2.Layout_liens_party_bid)),transform(recordof(liensv2.file_SearchAutokey()),self:=left));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',intdid,intbdid,LiensV2.str_bid_Autokey.Name+'Payload',plk,'')

export key_liens_AutokeyPayload_bid:= plk;