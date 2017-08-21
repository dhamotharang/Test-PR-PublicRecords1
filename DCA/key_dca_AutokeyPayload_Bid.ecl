import autokeyb2,doxie;
//fakepf := DCA.file_SearchAutokey();
fakepf := DCA.file_SearchAutokey_bid();

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,zero,dca.constants(' ').ak_qa_keyname_bid +'Payload',plk,'')

export key_dca_AutokeyPayload_Bid := plk;
