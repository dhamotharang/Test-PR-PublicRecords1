import autokeyb2,doxie;

fakepf := dataset([],Layouts_Txbus.Layout_Autokeys);

autokey_qa_name := Txbus.Constants.autokey_qa_name;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,bdid,autokey_qa_name+'Payload',plk,'')

export Key_Txbus_Payload := plk;
