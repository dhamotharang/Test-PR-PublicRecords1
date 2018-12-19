IMPORT NeustarWireless;

EXPORT Files := MODULE

	EXPORT Names := MODULE
		EXPORT Raw_In := '~' + NeustarWireless.Constants().ThorCluster + '::in::neustar_wireless';
		EXPORT Main	 :=  '~' + NeustarWireless.Constants().ThorCluster + '::base::neustar_wireless::main';
		EXPORT Activity_Status :=  '~' + NeustarWireless.Constants().ThorCluster + '::base::neustar_wireless::activity_status';
	END;

	EXPORT Raw_In := dataset(Names.Raw_in
												 ,{NeustarWireless.Layouts.Raw_In, string75 raw_file_name {virtual(logicalfilename)}}
												 ,CSV(HEADING(1),separator(['|']),terminator(['\n'])));


	EXPORT Base := MODULE
			EXPORT Main := dataset(Names.Main, Layouts.Base.Main, flat, opt);
			EXPORT Activity_Status := dataset(Names.Activity_Status, Layouts.Base.Activity_Status, flat, opt);
	END;

	
													
END;