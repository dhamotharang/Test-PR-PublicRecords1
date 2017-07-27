import autokeyb2,doxie;

fakepf := MFind.file_SearchAutokey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,0,MFind.constant.str_AutokeyName+'Payload',plk,'')

export Key_MFind_AutokeyPayload := plk;