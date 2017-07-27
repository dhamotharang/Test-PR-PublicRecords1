import autokeyb2,standard,doxie,ut,FBNv2;

KeyName       := cluster.cluster_out+'Key::FBNV2::';
dBase 		  := dataset([], recordof(File_SearchAutokey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'qa::autokey::payload',plk,'');
export Key_Payload :=plk;  