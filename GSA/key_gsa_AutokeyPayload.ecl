import autokeyb2,doxie;

fakepf := GSA.file_SearchAutokey();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,zero,gsa.constants(' ').ak_qa_keyname +'Payload',plk,'')

export key_gsa_AutokeyPayload := plk;

