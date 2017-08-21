import autokeyb2,doxie;

fakepf := dataset([],Layouts_Calbus.Layout_Autokeys);

autokey_qa_name := Calbus.Constants.bid_autokey_qa_name;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,bdid,autokey_qa_name+'Payload',plk,'')

export Key_Calbus_Payload_Bid := plk;
