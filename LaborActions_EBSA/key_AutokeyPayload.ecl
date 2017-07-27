import autokeyb2,doxie;

fakepf := LaborActions_EBSA.File_Base_Payload;

ak_qa_keyname := LaborActions_EBSA.Constants().ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload := plk;