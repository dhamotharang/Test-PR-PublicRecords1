import Ingenix_NatlProf, autokeyb2, doxie;

Layout_Autokeys := record
   recordof(Ingenix_NatlProf.file_SearchAutokey_Provider); 
end;

fakepf := dataset([], Layout_Autokeys);

autokey_qa_name := Ingenix_NatlProf.Constants.autokey_qa_name_prov;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,autokey_qa_name+'Payload',plk,'');

export Key_Provider_Payload := plk;