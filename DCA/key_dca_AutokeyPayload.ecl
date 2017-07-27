import autokeyb2,doxie;
fakepf := DCA.file_SearchAutokey();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,zero,dca.constants(' ').ak_qa_keyname +'Payload',plk,'')

export key_dca_AutokeyPayload := plk;