import	lib_fileservices,_control,RoxieKeyBuild,ut, DOPS;

export	Proc_Build_GWL_All_V2(string	pFileDate)	:=
function
	//Spray Raw File
	//Spray Raw File
	sprayEntityFile		:=	FileServices.SprayXml(	_control.IPAddress.bctlpedata10,
																								'/data/data_999/sanctions/bridger/in/'+pFileDate+'/MasterListEntityConverted.xml',
																								32768,
																								'Entity',,
																								'thor400_44',
																								'~thor_200::in::globalwatchlists::entity::'	+	pFileDate
																								,,,,true,true,true
																							);
	
	sprayCountryFile	:=	FileServices.SprayXml(	_control.IPAddress.bctlpedata10,
																								'/data/data_999/sanctions/bridger/in/'+pFileDate+'/MasterListCountryConverted.xml',
																								32768,
																								'Country',,
																								'thor400_44',
																								'~thor_200::in::globalwatchlists::country::'	+	pFileDate
																								,,,,true,true,true
																							);
	
	sprayFile	:=	parallel(sprayEntityFile,sprayCountryFile);
	
	//Add Raw File to Superfile
	addSuper	:=	sequential(	FileServices.StartSuperFileTransaction(),
														FileServices.AddSuperFile('~thor_200::in::globalwatchlists::masterlist_delete','~thor_200::in::globalwatchlists::masterlist_father',,true),
														FileServices.ClearSuperFile('~thor_200::in::globalwatchlists::masterlist_father'),
														FileServices.AddSuperFile('~thor_200::in::globalwatchlists::masterlist_father','~thor_200::in::globalwatchlists::masterlist',,true),
														FileServices.ClearSuperFile('~thor_200::in::globalwatchlists::masterlist'),
														FileServices.AddSuperFile('~thor_200::in::globalwatchlists::masterlist','~thor_200::in::globalwatchlists::entity::'	+	pFileDate),
														FileServices.AddSuperFile('~thor_200::in::globalwatchlists::masterlist','~thor_200::in::globalwatchlists::country::'	+	pFileDate),
														FileServices.FinishSuperFileTransaction(),
														FileServices.RemoveOwnedSubFiles('~thor_200::in::globalwatchlists::masterlist_delete',true)
													);
	
	//Create Base Files
	buildBase	:=	GlobalWatchLists.Proc_Build_GWL_Base_V2(pFileDate);
		
	//Create Keys
	buildKeys	:=	GlobalWatchLists.Proc_Build_GWL_Keys_V2(pFileDate);
	
	// Update DOPS
	updateDOPS						:=	DOPS.updateversion('GlobalWatchListV2Keys',pFileDate,'kgummadi@seisint.com,skasavajjala@seisint.com');
	updateAlpharettaDOPS	:=	DOPS.updateversion('GlobalWatchListV2Keys',pFileDate,'kgummadi@seisint.com,skasavajjala@seisint.com',,'N',,,'A');
	
	//Create OrbitI build
	createAlpharettabuild  := GlobalWatchLists.Proc_OrbitI_CreateBuild(pFileDate,'V2');
	
	//Add build Stats
	out_stats := GlobalWatchLists.out_GWLV2_population_stats(pFileDate);

	return	sequential(sprayFile,addSuper,buildBase,buildKeys,updateDOPS,updateAlpharettaDOPS,createAlpharettabuild,out_stats);
end;