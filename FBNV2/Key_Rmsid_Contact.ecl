import  FBNV2,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::FBNV2::';
				 
dBase 	      := File_FBN_Contact_Base;
dSort         := sort(distribute(dBase , hash(tmsid,rmsid)),tmsid,rmsid,local);


export Key_rmsid_Contact := INDEX(dSort ,{tmsid,rmsid},{dSort},KeyName +doxie.Version_SuperKey+'::Rmsid_contact');

