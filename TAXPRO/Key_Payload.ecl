import autokeyb2,standard,doxie,ut,TAXPRO;

KeyName       := cluster.cluster_out+'Key::Taxpro::';
dBase 		  := dataset([], layout.payload);

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'qa::autokey::payload',plk,'');
export Key_Payload :=plk;  