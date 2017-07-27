import autokeyb2,doxie;

fakepf := NaturalDisaster_Readiness.File_Base_Payload;

ak_qa_keyname := NaturalDisaster_Readiness.Constants().ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload := plk;