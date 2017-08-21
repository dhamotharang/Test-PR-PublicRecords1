import autokeyb2,doxie,ut,standard;

KeyName       := '~thor_data400::Key::fcc::';
dBase 		  := dataset([], fcc.Layout_Payload);

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'qa::autokey::bid::payload',plk,'');
export Key_bid_Payload :=plk;  