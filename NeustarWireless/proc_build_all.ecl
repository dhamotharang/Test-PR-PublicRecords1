IMPORT _control,ut,PromoteSupers, NeustarWireless, Scrubs_NeustarWireless;

//pVersion = input filedate
EXPORT proc_build_all(STRING pVersion) := FUNCTION
  #workunit('name', 'Yogurt: Neustar Wireless Phones Build ' + pVersion);

	//Email that build has started
	send_build_start_email := NeustarWireless.Send_Emails(pversion, pBuildMessage:='proc_build_all started').BuildMessage;
	
	//Spray Input File
	spray_file := fSprayFiles(pVersion);
	
	//Build base files
	build_base_files := NeustarWireless.proc_build_base(pVersion);

  full_build	:=	SEQUENTIAL(	send_build_start_email
											,spray_file
											//tbd,Scrubs_NeustarWireless.PreBuildScrubs(pVersion)
											,build_base_files
											//tbd,NeustarWireless.Strata_Population_Stats(pVersion).all
										) : SUCCESS(NeustarWireless.Send_Emails(pVersion).BuildSuccess),
												FAILURE(NeustarWireless.Send_Emails(pVersion).BuildFailure);
												
	 RETURN full_build;
		
END;