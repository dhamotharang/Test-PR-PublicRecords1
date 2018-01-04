import autokeyb2, Driversv2, data_services;

Layout_DL_AutoKeys  := record
	DriversV2.Layout_Drivers;
	unsigned1 zero  := 0;
	string1   blank := '';
end;

fakepf := dataset([],Layout_DL_AutoKeys);

t := data_services.data_location.prefix() + 'thor400_92::key::dl_VTSA::autokey::qa::';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,zero,t+'Payload',plk,'')

export Key_AutoKey_Payload := plk;