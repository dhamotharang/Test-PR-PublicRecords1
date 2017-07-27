import autokeyb2,standard,doxie,ut;

KeyName       := Entiera.Entiera_Constants('').cluster +'Key::Entiera::';
dBase 		  := dataset([], recordof(File_Entiera_AutoKey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'autokey::qa::payload',plk,'');
export Key_Payload :=plk;  

