IMPORT _control,ut,PromoteSupers, NeustarWireless, Scrubs_NeustarWireless;

//pVersion = input filedate
/*
	Sample:  NeustarWireless.proc_build_all('20180903'); 
  IMPORTANT: Date parameter must match the date of the folder and filename to process on the landing zone 
						 //data/hds_2/neustar_wireless/data/20180903/Wireless2_20180903.txt
	This is a full file replace that uses the SALT injest process.  Files should be processed in sequential order.  Only one build may run at a time.
*/

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
											,NeustarWireless.proc_run_stats
											//tbd,NeustarWireless.Strata_Population_Stats(pVersion).all
										) : SUCCESS(NeustarWireless.Send_Emails(pVersion).BuildSuccess),
												FAILURE(NeustarWireless.Send_Emails(pVersion).BuildFailure);
												
	 RETURN full_build;
		
END;