import CNLD_Facilities, autokeyb2, doxie;

Layout_Autokeys := record
   recordof(CNLD_Facilities.file_Facilities_Autokeys); 
end;

fakepf := dataset([], Layout_Autokeys);

autokey_qa_name := CNLD_Facilities.constants.ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,autokey_qa_name+'Payload',plk,'');

export key_autokey_payload := plk;
