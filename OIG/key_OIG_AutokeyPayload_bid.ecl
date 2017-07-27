import autokeyb2,doxie;
fakepf := project(OIG.File_OIG_KeyBaseTemp_bid,transform(Layouts.KeyBuild, self.bdid:=left.bid;self:=left;));

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,'~thor_data400::key::oig::qa::autokey::bid::payload',plk,'');


export key_OIG_AutokeyPayload_bid := plk;

