import autokeyb2,doxie;

Layout_DL_AutoKeys  := record
	DriversV2.Layout_Drivers;
	unsigned1 zero  := 0;
	string1   blank := '';
end;

fakepf := dataset([],Layout_DL_AutoKeys);

t := Driversv2.Constants.autokey_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,t+'Payload',plk,'')

export Key_DL_AutoKey_Payload := plk;