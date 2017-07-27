import autokeyb2,standard,doxie,ut,INFOUSA;

KeyName       := cluster.cluster_out+'Key::infoUSA::ABIUS::';
dBase 		  := dataset([], recordof(File_ABIUS_SearchAutokey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'qa::autokey::payload',plk,'');
export Key_Abius_Payload :=plk;  