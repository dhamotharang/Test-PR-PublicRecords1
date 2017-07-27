import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::FBNV2::';
dBase 	  	  := File_FBN_Business_Base;
dSort         := sort(distribute(dBase,Hash(Tmsid,rmsid)),Tmsid,RMSID,local);

export Key_RMSID  := INDEX(dSort ,{TMSID},{RMSID},KeyName+doxie.Version_SuperKey+'::Rmsid');
