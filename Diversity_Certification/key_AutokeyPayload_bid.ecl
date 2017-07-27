import autokeyb2,doxie;
rec_lay:=RECORD
  Diversity_Certification.Layouts.Auto_KeyBuild-bid;
 END;
fakepf  :=project(Diversity_Certification.File_SearchAutoKey,transform(rec_lay,self.bdid:=left.bid,self:=left));
autokey_qa_name :=  Diversity_Certification.Constants().Bid_autokey_qa_name;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,autokey_qa_name+'Payload',plk,'');

export key_AutokeyPayload_bid := plk;