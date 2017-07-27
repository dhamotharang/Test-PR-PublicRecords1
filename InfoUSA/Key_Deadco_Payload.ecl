import autokeyb2,standard,doxie,ut,INFOUSA;

KeyName       := cluster.cluster_out+'Key::infoUSA::DEADCO::';
dBase 		  := dataset([], recordof(File_Deadco_SearchAutokey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'qa::autokey::payload',plk,'');

export Key_Deadco_Payload :=  plk;