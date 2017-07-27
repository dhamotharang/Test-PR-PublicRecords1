import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::FBNV2::';

dBase 	  	  := File_FBN_Business_Base;
dSort         := sort(distribute(dBase,hash(tmsid,rmsid)),tmsid,rmsid,local);
export  Key_Rmsid_Business:= INDEX(dSort ,{tmsid,rmsid},{dBase},KeyName+doxie.Version_SuperKey+'::Rmsid_Business');

