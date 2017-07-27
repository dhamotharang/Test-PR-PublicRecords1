import autokeyb2,doxie;

fakepf := LaborActions_MSHA.File_Base_Payload_Mine;

ak_qa_keyname := LaborActions_MSHA.Constants(,'base_mine').ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload_Mine := plk;