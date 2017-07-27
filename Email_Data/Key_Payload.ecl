import autokeyb2,standard,doxie,ut;

KeyName     := Constants('').cluster +'Key::email_data::';
dBase 		  := dataset([], recordof(File_AutoKey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'autokey::qa::payload',plk,'');
export Key_Payload :=plk;  

