import autokeyb2,doxie;

fakepf := CourtLink.FileSearchAutoKey();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,zero,CourtLink.constants(' ').ak_qa_keyname +'Payload',plk,'')

export key_AutokeyPayload := plk;