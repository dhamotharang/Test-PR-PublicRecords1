import autokeyb2,doxie;

rec_lay:=RECORD
  Diversity_Certification.Layouts.Auto_KeyBuild;
 END;
 
fakepf  				:= project(Diversity_Certification.File_SearchAutoKey,transform(rec_lay,self:=left));
autokey_qa_name := Diversity_Certification.Constants().autokey_qa_name;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,autokey_qa_name+'Payload',plk,'');

export key_AutokeyPayload := plk;