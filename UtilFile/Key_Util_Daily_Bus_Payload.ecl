Import Data_Services, autokeyb2,doxie;

//util bus autokeys
Layout_Autokeys := RECORD
	UtilFile.Layout_util_daily_bus_out;
	integer zero := 0;
	string  blank := '';
END;

fakepf := project(dataset([],Layout_Autokeys), transform(Layout_Autokeys, self.ssn := '', self := left));

autokey_qa_name := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::utility::daily::bus::autokey::qa::';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zero,bdid,autokey_qa_name+'Payload',plk,'')

export Key_Util_Daily_Bus_Payload := plk;
