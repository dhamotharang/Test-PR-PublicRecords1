IMPORT Obituaries, ut, header, _Control;
EXPORT proc_tributes_obits_buildall(string	filedate) := FUNCTION
	#workunit('name','Yogurt: Tributes/Obituary Build '+ filedate);

	// Build Checks
	doTributes	   :=	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/hds_4/death_master/in/obituary','memorial_lexis_nexis*xml'));
	doObits			   :=	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/hds_4/death_master/in/obituary_dotcom','Obit*txt'));
	doTributeNews  := EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/hds_4/death_master/in/newspaper/','lexisnexis_newspaper_weekly*xml'));

	//Spray files.  
	SprayTributes			:= Obituaries.proc_obit_sprayxml;
	SprayObituaryData := Obituaries.proc_spray_obituary;
	SprayTributeNews  := Obituaries.proc_tributes_sprayxml;

	//Clean raw files  and rollup on current base file to create base input file
	Build_tributes_raw	:= Obituaries.Build_Tribute_base;
	Build_obituary_raw	:= Obituaries.Build_obituary_base;

	//Process build file for death_master
	Build_death_master_file	:= Obituaries.map_obituary_to_V3;

	//Move raw input file to history
	mv_tributes_raw	:=	SEQUENTIAL
											(
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::tributes_dmaster_raw_history','~thor_data400::in::tributes_dmaster_raw',,TRUE),
												FileServices.ClearSuperFile('~thor_data400::in::tributes_dmaster_raw'),
												FileServices.FinishSuperFileTransaction()
											);
	mv_newspaper_raw	:=	SEQUENTIAL
											(
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::newspaper_tributes_history','~thor_data400::in::newspaper_tributes',,TRUE),
												FileServices.ClearSuperFile('~thor_data400::in::newspaper_tributes'),
												FileServices.FinishSuperFileTransaction()
											);										
										
	mv_obituary_raw	:=	SEQUENTIAL
											(
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::obituarydata_raw_history','~thor_data400::in::obituarydata_raw',,TRUE),
												FileServices.ClearSuperFile('~thor_data400::in::obituarydata_raw'),
												FileServices.FinishSuperFileTransaction()
											);

	RunBuild				:=	SEQUENTIAL
											(
												IF(doTributes or doTributeNews,
													SEQUENTIAL(	IF(doTributes,
													               sequential(SprayTributes(filedate),
																				            Map_TributesRaw_Conversion),
													            OUTPUT('No New Tribute input files'));
													            IF(doTributeNews,
																			   sequential(SprayTributeNews(filedate).sprayfiles,
																				            Map_Newspaper_Conversion),
																			OUTPUT('No New Tribute Newspaper input files'));
																			Build_tributes_raw,
																			mv_tributes_raw,
																			mv_newspaper_raw
													),
												  OUTPUT('No new raw input files, skip Tributes build')
												),
												IF(doObits,
													SEQUENTIAL(	SprayObituaryData(filedate),
																			Build_obituary_raw,
																			mv_obituary_raw
													),
													OUTPUT('No new raw input files, skip ObituaryData build')
												),
												IF(doTributes OR doObits or doTributeNews,
													SEQUENTIAL(	Build_death_master_file(filedate),
																			Obituaries.out_base_tributes_stats(filedate),
																			Obituaries.out_ObituaryData_stats(filedate),
													),
													OUTPUT('No new raw input files, skip Tributes and Obituaries build')
												)
											);

	RETURN RunBuild;
	
END;
